unit Roster;
{
    Copyright 2001, Peter Millard

    This file is part of Exodus.

    Exodus is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Exodus is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Exodus; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

interface

uses
    NodeItem, JabberID, Presence, Signals, Unicode, XMLTag,
    SysUtils, Classes;

type

    TRosterEvent = procedure(event: string; tag: TXMLTag; ritem: TJabberRosterItem) of object;
    TRosterListener = class(TSignalListener)
    public
    end;

    TRosterSignal = class(TSignal)
    public
        procedure Invoke(event: string; tag: TXMLTag; ritem: TJabberRosterItem = nil); overload;
        function addListener(callback: TRosterEvent): TRosterListener; overload;
    end;

    TJabberRoster = class(TWideStringList)
    private
        _js: TObject;
        _groups: TWidestringlist;
        _unfiled: TJabberGroup;
        _pres_cb: integer;

        procedure ParseFullRoster(event: string; tag: TXMLTag);
        procedure Callback(event: string; tag: TXMLTag);
        procedure bmCallback(event: string; tag: TXMLTag);
        procedure presCallback(event: string; tag: TXMLTag; pres: TJabberPres);
        procedure checkGroups(ri: TJabberRosterItem);
        function  checkGroup(grp: Widestring): TJabberGroup;
        function  getNumGroups: integer;
        function  getGroupIndex(idx: integer): TJabberGroup;
        procedure fireBookmark(bm: TJabberBookmark);

        function getItem(index: integer): TJabberRosterItem;

    public
        Bookmarks: TWideStringList;

        constructor Create;
        destructor Destroy; override;

        procedure Clear; override;

        procedure SetSession(js: TObject);
        procedure Fetch;
        procedure SaveBookmarks;

        procedure AddItem(sjid, nickname, group: Widestring; subscribe: boolean);
        procedure UpdateGroupLists(ritem: TJabberRosterItem);
        procedure AddBookmark(sjid: Widestring; bm: TJabberBookmark);
        procedure RemoveBookmark(sjid: Widestring);
        procedure UpdateBookmark(bm: TJabberBookmark);

        function Find(sjid: Widestring): TJabberRosterItem; reintroduce; overload;

        function addGroup(grp: Widestring): TJabberGroup;
        function getGroup(grp: Widestring): TJabberGroup;
        procedure removeGroup(grp: TJabberGroup);

        function getGroupItems(grp: Widestring; online: boolean): TList;
        function getGroupCount(grp_name: Widestring; online: boolean): integer;

        property GrpList: TWidestringlist read _groups;
        property GroupsCount: integer read getNumGroups;
        property Groups[index: integer]: TJabberGroup read getGroupIndex;
        property Items[index: integer]: TJabberRosterItem read getItem;
    end;

    TRosterAddItem = class
    private
        jid: string;
        grp: string;
        nick: string;
        do_subscribe: boolean;

        procedure AddCallback(event: string; tag: TXMLTag);
    public
        constructor Create(sjid, nickname, group: string; subscribe: boolean);
    end;

resourcestring
    sGrpBookmarks = 'Bookmarks';

{---------------------------------------}
{---------------------------------------}
{---------------------------------------}
implementation
uses
    JabberConst, iq, s10n, XMLUtils, Session;

{---------------------------------------}
{---------------------------------------}
{---------------------------------------}
constructor TJabberRoster.Create;
begin
    inherited;
    Bookmarks := TWideStringList.Create();
    _groups := TWidestringlist.Create();
    _unfiled := TJabberGroup.Create('Unfiled');
end;

{---------------------------------------}
destructor TJabberRoster.Destroy;
begin
    ClearStringListObjects(_groups);
    _groups.Free();
    Bookmarks.Free;

    inherited Destroy;
end;

{---------------------------------------}
procedure TJabberRoster.Clear;
begin
    // Free all the roster items.
    ClearStringListObjects(Bookmarks);
    ClearStringListObjects(Self);
    ClearStringListObjects(_groups);

    Bookmarks.Clear;
    _groups.Clear();

    inherited Clear();
end;

{---------------------------------------}
function TJabberRoster.getItem(index: integer): TJabberRosterItem;
begin
    // return a specific TJabberRosterItem from the Objects list
    if ((index < 0) or (index >= Self.Count)) then
        Result := nil
    else
        Result := TJabberRosterItem(Self.Objects[index]);
end;

{---------------------------------------}
procedure TJabberRoster.SetSession(js: TObject);
begin
    _js := js;
    with TJabberSession(_js) do begin
        RegisterCallback(Callback, '/packet/iq/query[@xmlns="jabber:iq:roster"]');
        _pres_cb := RegisterCallback(presCallback);
    end;
end;

{---------------------------------------}
procedure TJabberRoster.Fetch;
var
    js: TJabberSession;
    f_iq: TJabberIQ;
    bm_iq: TJabberIQ;
begin
    js := TJabberSession(_js);
    f_iq := TJabberIQ.Create(js, js.generateID(), ParseFullRoster, 180);
    with f_iq do begin
        iqType := 'get';
        toJID := '';
        Namespace := XMLNS_ROSTER;
        Send();
    end;

    bm_iq := TJabberIQ.Create(js, js.generateID(), bmCallback, 180);
    with bm_iq do begin
        iqType := 'get';
        toJid := '';
        Namespace := XMLNS_PRIVATE;
        with qtag.AddTag('storage') do
            setAttribute('xmlns', XMLNS_BM);
        Send();
    end;
end;

{---------------------------------------}
procedure TJabberRoster.bmCallback(event: string; tag: TXMLTag);
var
    bms: TXMLTagList;
    i, idx: integer;
    stag: TXMLTag;
    bm: TJabberBookmark;
    jid: string;
begin
    // get all of the bm's
    if ((event = 'xml') and (tag.getAttribute('type') = 'result')) then begin
        // we got a response..
        {
        <iq type="set" id="jcl_4">
            <query xmlns="jabber:iq:private">
                <storage xmlns="storage:bookmarks">
                    <conference jid="jdev@conference.jabber.org"><nick>pgmillard</nick>
                    </conference>
                </storage>
        </query></iq>
        }

        stag := tag.QueryXPTag('/iq/query/storage');
        if (stag <> nil) then begin
            bms := stag.ChildTags();
            for i := 0 to bms.count -1  do begin
                jid := WideLowerCase(bms[i].GetAttribute('jid'));
                idx := Bookmarks.IndexOf(jid);
                if (idx >= 0) then begin
                    // remove the existing bm
                    TJabberBookmark(Bookmarks.Objects[idx]).Free;
                    Bookmarks.Delete(idx);
                end;
                bm := TJabberBookmark.Create(bms[i]);
                Bookmarks.AddObject(jid, bm);
                checkGroup(sGrpBookmarks);
            end;

            for i := 0 to Bookmarks.Count - 1 do
                FireBookmark(TJabberBookmark(Bookmarks.Objects[i]));
            bms.Free();
        end;
    end;
end;

{---------------------------------------}
procedure TJabberRoster.SaveBookmarks;
var
    s: TJabberSession;
    stag, iq: TXMLTag;
    i: integer;
begin
    // save bookmarks to jabber:iq:private
    s := TJabberSession(_js);

    iq := TXMLTag.Create('iq');
    with iq do begin
        setAttribute('type', 'set');
        setAttribute('id', s.generateID());
        with AddTag('query') do begin
            setAttribute('xmlns', XMLNS_PRIVATE);
            stag := AddTag('storage');
            stag.setAttribute('xmlns', XMLNS_BM);
            for i := 0 to Bookmarks.Count - 1 do
                TJabberBookmark(Bookmarks.Objects[i]).AddToTag(stag);
        end;
    end;
    s.SendTag(iq);
end;

{---------------------------------------}
procedure TJabberRoster.Callback(event: string; tag: TXMLTag);
var
    q: TXMLTag;
    ritems: TXMLTagList;
    ri: TJabberRosterItem;
    idx, i: integer;
    iq_type, j: Widestring;
    s: TJabberSession;
begin
    // callback from the session
    s := TJabberSession(_js);

    // this is some kind of roster push
    iq_type := tag.GetAttribute('type');
    if (iq_type <> 'set') then exit;

    // a roster push
    q := tag.GetFirstTag('query');
    if q = nil then exit;
    ritems := q.QueryTags('item');

    for i := 0 to ritems.Count - 1 do begin
        // XXX: stringprep instead of WideLowerCase
        j := WideLowerCase(ritems[i].GetAttribute('jid'));
        ri := Find(j);

        if ri = nil then begin
            ri := TJabberRosterItem.Create;
            Self.AddObject(j, ri);
        end;

        UpdateGroupLists(ri);
        ri.parse(ritems[i]);
        checkGroups(ri);
        s.FireEvent('/roster/item', tag, ri);
        if (ri.subscription = 'remove') then begin
            idx := Self.indexOfObject(ri);
            ri.Free;
            Self.Delete(idx);
        end;
    end;

    ritems.Free();
end;

{---------------------------------------}
procedure TJabberRoster.presCallback(event: string; tag: TXMLTag; pres: TJabberPres);
var
    ri: TJabberRosterItem;
    i, idx: integer;
    cur_grp: Widestring;
    go: TJabberGroup;
begin
    // we are getting /preseence events
    if ((event = '/presence/online') or (event = '/presence/offline')) then begin

        // this JID is coming online... inc group counters
        ri := Self.Find(pres.fromJid.jid);
        if (ri = nil) then
            ri := Self.Find(pres.fromJid.full);

        if (ri = nil) then exit;

        // special case for unfiled
        if (ri.Groups.Count = 0) then begin
            _unfiled.setPresence(ri.jid.jid, pres);
            exit;
        end;

        // iterate over all groups for this user.
        for i := 0 to ri.Groups.Count - 1 do begin
            cur_grp := ri.Groups[i];
            idx := _groups.IndexOf(cur_grp);
            if (idx >= 0) then begin
                go := TJabberGroup(_groups.Objects[i]);
                go.setPresence(ri.jid, pres);
            end;
        end;
    end;
    
end;

{---------------------------------------}
procedure TJabberRoster.UpdateGroupLists(ritem: TJabberRosterItem);
var
    i, idx: integer;
    g: TJabberGroup;
begin

    // OK, the groups in this item, have been updated from an
    // event inside Exodus... We're getting a push from the server
    // telling us to update the data structures we already have manipulated.

    // make sure we remove them from unfiled if they
    // were there, and they now have at least 1 group.
    if (ritem.groups.Count > 0) then begin
        if (_unfiled.inGroup(ritem.jid)) then
            _unfiled.removeJid(ritem.jid);
    end;

    // So look at all of the groups.. if the jid was in that
    // group, but ritem doesn't have that jid listed anymore,
    // then remove it from the Group object.
    // If the group is listed in groups, but isn't in the grp object, then
    // add it back
    for i := 0 to _groups.Count - 1 do begin
        g := TJabberGroup(_groups.Objects[i]);
        if (g.inGroup(ritem.jid)) then begin
            idx := ritem.Groups.IndexOf(g.FullName);
            if (idx = -1) then
                g.RemoveJid(ritem.jid);
        end
        else if (ritem.Groups.IndexOf(g.Fullname) >= 0) then
            g.AddJid(ritem.jid);
    end;

    // If they aren't in any groups, put them in unfiled.
    if (ritem.Groups.Count = 0) then begin
        if (not _unfiled.inGroup(ritem.jid)) then
            _unfiled.AddJid(ritem.jid);
    end;

end;

{---------------------------------------}
function TJabberRoster.GetGroupCount(grp_name: Widestring; online: boolean): integer;
var
    i: integer;
    go: TJabberGroup;
begin
    if (grp_name = '') then begin
        // get all items in no groups
        if (online) then
            Result := _unfiled.Online
        else
            Result := _unfiled.Total;
        exit;
    end;

    Result := 0;
    i := _groups.IndexOf(grp_name);
    if (i = -1) then exit;

    go := TJabberGroup(_groups.Objects[i]);
    if (online) then
        Result := go.Online
    else
        Result := go.Total;
end;

{---------------------------------------}
procedure TJabberRoster.checkGroups(ri: TJabberRosterItem);
var
    g: integer;
    go: TJabberGroup;
    cur_grp: Widestring;
    p: TJabberPres;
begin
    if ((ri.Subscription <> 'to') and (ri.Subscription <> 'both')) then exit;

    // make sure _groups is populated.
    p := MainSession.ppdb.FindPres(ri.jid.jid, '');
    for g := 0 to ri.Groups.Count - 1 do begin
        cur_grp := ri.Groups[g];

        go := checkGroup(cur_grp);
        if (not go.inGroup(ri.jid)) then
            go.AddJid(ri.jid);

        go.setPresence(ri.jid.jid, p);
    end;
end;

{---------------------------------------}
function TJabberRoster.checkGroup(grp: Widestring): TJabberGroup;
var
    i: integer;
    go: TJabberGroup;
begin
    i := _groups.IndexOf(grp);
    if (i = -1) then begin
        go := TJabberGroup.Create(grp);
        _groups.AddObject(grp, go);
    end
    else
        go := TJabberGroup(_groups.Objects[i]);

    Result := go;
end;

{---------------------------------------}
function TJabberRoster.getNumGroups: integer;
begin
    Result := _groups.Count;
end;

{---------------------------------------}
function  TJabberRoster.getGroupIndex(idx: integer): TJabberGroup;
begin
    if (idx >= _groups.Count) then
        Result := nil
    else
        Result := TJabberGroup(_groups.Objects[idx]);
end;

{---------------------------------------}
function TJabberRoster.Find(sjid: Widestring): TJabberRosterItem;
var
    i: integer;
begin
    i := indexOf(WideLowerCase(sjid));
    if (i >= 0) and (i < Count) then
        Result := TJabberRosterItem(Objects[i])
    else
        Result := nil;
end;

{---------------------------------------}
function TJabberRoster.getGroup(grp: Widestring): TJabberGroup;
var
    i: integer;
begin
    i := _groups.indexOf(grp);
    if (i >= 0) then
        Result := TJabberGroup(_groups.Objects[i])
    else
        Result := nil;
end;

{---------------------------------------}
function TJabberRoster.addGroup(grp: Widestring): TJabberGroup;
begin
    Result := checkGroup(grp);
end;

{---------------------------------------}
procedure TJabberRoster.removeGroup(grp: TJabberGroup);
var
    i: integer;
begin
    i := _groups.IndexOfObject(grp);
    if (i = -1) then exit;

    _groups.Delete(i);
    grp.Free();
end;

{---------------------------------------}
function TJabberRoster.GetGroupItems(grp: Widestring; online: boolean): TList;
var
    i: integer;
    ri: TJabberRosterItem;
begin
    Result := TList.Create();
    for i := 0 to Self.Count - 1 do begin
        ri := Self.Items[i];
        if (ri.Groups.IndexOf(grp) >= 0) then begin
            if (((online) and (ri.IsOnline)) or (not online)) then
                Result.add(ri);
        end;
    end;
end;


{---------------------------------------}
procedure TJabberRoster.AddItem(sjid, nickname, group: Widestring; subscribe: boolean);
begin
    // send a iq-set
    TRosterAddItem.Create(sjid, nickname, group, subscribe);
end;

{---------------------------------------}
procedure TJabberRoster.FireBookmark(bm: TJabberBookmark);
var
    p: TXMLTag;
    t: TXMLTag;
begin
    p := TXMLTag.Create('bm');
    t := bm.AddToTag(p);
    with TJabberSession(_js) do
        FireEvent('/roster/bookmark', t);
    p.Free();
end;

{---------------------------------------}
procedure TJabberRoster.AddBookmark(sjid: Widestring; bm: TJabberBookmark);
var
    tbm : TJabberBookmark;
    i : integer;
begin
    // Add a new bookmark to the list,
    // save them, and fire out a new event
    i := Bookmarks.IndexOf(sjid);
    if (i >= 0) then begin
        tbm := TJabberBookmark(Bookmarks.Objects[i]);
        tbm.Copy(bm);
        bm.Free();
    end
    else begin
        Self.Bookmarks.AddObject(sjid, bm);
        tbm := bm;
    end;

    Self.SaveBookmarks();
    fireBookmark(tbm);
end;

{---------------------------------------}
procedure TJabberRoster.RemoveBookmark(sjid: Widestring);
var
    bm: TJabberBookmark;
    i: integer;
    t: TXMLTag;
begin
    // remove a bm from the list
    i := Bookmarks.IndexOf(sjid);
    if ((i >= 0) and (i < Bookmarks.Count)) then begin
        t := TXMLTag.Create('bm-delete');
        bm := TJabberBookmark(Bookmarks.Objects[i]);
        bm.AddToTag(t);
        TJabberSession(_js).FireEvent('/session/del-bookmark', t);
        t.Free();
        bm.Free();
        Bookmarks.Delete(i);
    end;
    Self.SaveBookmarks();
end;

{---------------------------------------}
procedure TJabberRoster.UpdateBookmark(bm: TJabberBookmark);
begin
    Self.SaveBookmarks();
    Self.fireBookmark(bm);
end;

{---------------------------------------}
procedure TJabberRoster.ParseFullRoster(event: string; tag: TXMLTag);
var
    ct, etag: TXMLTag;
    ritems: TXMLTagList;
    idx, i: integer;
    ri: TJabberRosterItem;
    s: TJabberSession;
    tmp_jid: TJabberID;
begin
    // parse the full roster push

    // Don't clear out the list.. we may have gotten roster pushes
    // in before this from mod_groups or something similar.

    s := TJabberSession(_js);

    if (event <> 'xml') then begin
        // timeout!
        if (s.Stream <> nil) then Self.Fetch();
    end

    else if (tag.GetAttribute('type') = 'error') then begin
        // some kind of roster fetch error
        etag := tag.GetFirstTag('error');
        if (etag <> nil) then begin
            if (etag.GetAttribute('code') = '404') then begin
                Self.Fetch();
                exit;
            end;
        end;

        // this will happen if people are not using
        // mod_roster, but using mod_groups or something
        // similar
        s.FireEvent('/roster/start', nil);
        s.FireEvent('/roster/end', nil);
        exit;
    end

    else begin
        // fire off the start event..
        // then cycle thru all the item tags
        s.FireEvent('/roster/start', tag);
        ritems := tag.QueryXPTags('/iq/query/item');
        for i := 0 to ritems.Count - 1 do begin
            ct := ritems.Tags[i];
            idx := Self.IndexOf(ct.GetAttribute('jid'));
            if (idx = -1) then
                ri := TJabberRosterItem.Create
            else
                ri := TJabberRosterItem(Self.Objects[idx]);
            ri.parse(ct);
            checkGroups(ri);
            if (idx = -1) then
                AddObject(WideLowerCase(ri.jid.Full), ri);
            s.FireEvent('/roster/item', ritems.Tags[i], ri);
        end;

        // I know this is evil... but lets just put in a "fake"
        // roster item which represents us.
        // this way, when we receive our own presence, we just
        // let the normal stuff render it.
        ct := TXMLTag.Create('item');
        tmp_jid := TJabberID.Create(s.Jid);
        ct.setAttribute('jid', tmp_jid.jid);
        tmp_jid.Free();
        ct.setAttribute('subscription', 'both');
        ct.setAttribute('name', s.Username);
        ri := TJabberRosterItem.Create();
        ri.parse(ct);
        Self.AddObject(WideLowerCase(ri.jid.Full), ri);
        s.FireEvent('/roster/item', ct, ri);
        ct.Free();

        ritems.Free();
        s.FireEvent('/roster/end', nil);
    end;
end;

{---------------------------------------}
{---------------------------------------}
{---------------------------------------}
constructor TRosterAddItem.Create(sjid, nickname, group: string; subscribe: boolean);
var
    iq: TJabberIQ;
begin
    inherited Create();

    jid := sjid;
    nick := nickname;
    grp := group;
    do_subscribe := subscribe;

    iq := TJabberIQ.Create(MainSession, MainSession.generateID, Self.AddCallback);
    with iq do begin
        Namespace := XMLNS_ROSTER;
        iqType := 'set';
        with qTag.AddTag('item') do begin
            setAttribute('jid', jid);
            setAttribute('name', nick);
            if group <> '' then
                AddBasicTag('group', grp);
        end;
    end;
    iq.Send;
end;

{---------------------------------------}
procedure TRosterAddItem.AddCallback(event: string; tag: TXMLTag);
var
    iq_type: string;
begin
    // callback for the roster add.
    if (tag <> nil) then begin
        iq_type := tag.getAttribute('type');
        if (((iq_type = 'set') or (iq_type = 'result')) and (do_subscribe)) then
            SendSubscribe(jid, MainSession
            );
    end;

    Self.Free();
end;



{---------------------------------------}
{---------------------------------------}
{---------------------------------------}
function TRosterSignal.addListener(callback: TRosterEvent): TRosterListener;
var
    l: TRosterListener;
begin
    l := TRosterListener.Create();
    l.callback := TMethod(callback);
    inherited addListener('', l);
    Result := l;
end;

{---------------------------------------}
procedure TRosterSignal.Invoke(event: string; tag: TXMLTag; ritem: TJabberRosterItem = nil);
var
    i: integer;
    l: TRosterListener;
    cmp, e: string;
    sig: TRosterEvent;
begin
    // dispatch this to all interested listeners
    cmp := Lowercase(Trim(event));
    invoking := true;
    for i := 0 to Self.Count - 1 do begin
        e := Strings[i];
        l := TRosterListener(Objects[i]);
        sig := TRosterEvent(l.callback);
        if (e <> '') then begin
            // check to see if the listener's string is a substring of the event
            if (Pos(e, cmp) >= 1) then begin
                try
                    sig(event, tag, ritem);
                except
                    on x: Exception do
                        Dispatcher.handleException(Self, x, l, tag);
                end;
            end;
        end
        else begin
            try
                sig(event, tag, ritem);
            except
                on x: Exception do
                    Dispatcher.handleException(Self, x, l, tag);
            end;
        end;
    end;
    invoking := false;

    if change_list.Count > 0 then
        Self.processChangeList();

end;

end.


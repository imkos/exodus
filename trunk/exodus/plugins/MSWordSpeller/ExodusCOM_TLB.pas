unit ExodusCOM_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2/12/2003 9:33:52 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\src\exodus\exodus\Exodus.exe (1)
// LIBID: {219E0029-5710-4C9B-BE33-4C7F046D7792}
// LCID: 0
// Helpfile: 
// HelpString: Exodus COM Plugin interfaces
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v1.0 ExodusWordSpeller, (D:\src\exodus\exodus\plugins\MSWordSpeller\ExodusWordSpeller.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ExodusCOMMajorVersion = 1;
  ExodusCOMMinorVersion = 0;

  LIBID_ExodusCOM: TGUID = '{219E0029-5710-4C9B-BE33-4C7F046D7792}';

  IID_IExodusController: TGUID = '{47213401-DAB2-4560-82F7-E5AB15C34397}';
  CLASS_ExodusController: TGUID = '{35B80906-4D4D-4A1D-8BB2-1F0029916422}';
  IID_IExodusChat: TGUID = '{27176DA5-4EEB-442F-9B1F-D25EF948B9CB}';
  CLASS_ExodusChat: TGUID = '{DB3F5C90-0575-47E4-8F00-EED79757A97B}';
  IID_IExodusPlugin: TGUID = '{72470D1C-9A66-4735-A7CF-446F43561C92}';
  IID_IExodusChatPlugin: TGUID = '{2C576B16-DD6A-4E8C-8DEB-38E255B48A88}';
  IID_IExodusRoster: TGUID = '{29B1C26F-2F13-47D8-91C4-A4A5AC43F4A9}';
  CLASS_ExodusRoster: TGUID = '{438DF52E-F892-456B-9FB0-3C64DBB85240}';
  IID_IExodusPPDB: TGUID = '{284E49F2-2006-4E48-B0E0-233867A78E54}';
  CLASS_ExodusPPDB: TGUID = '{41BB1EC9-3299-45C3-BBA9-7DD897F29826}';
  IID_IExodusRosterItem: TGUID = '{F710F80C-C74A-4A69-8D2B-023504125B96}';
  CLASS_ExodusRosterItem: TGUID = '{9C6A0965-39B0-4D72-A143-D210FB1BA988}';
  IID_IExodusPresence: TGUID = '{D2FD3425-40CE-469F-A95C-1C80B7FF3119}';
  CLASS_ExodusPresence: TGUID = '{B9EED6FA-AB95-48CA-B485-1AF7E3CC0D0B}';
  IID_IExodusAuth: TGUID = '{D33EA5B9-23FD-4E43-B5B7-3CCFD0F5CDD0}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum ChatParts
type
  ChatParts = TOleEnum;
const
  HWND_MsgInput = $00000000;
  Ptr_MsgInput = $00000001;
  HWND_MsgOutput = $00000002;
  Ptr_MsgOutput = $00000003;

// Constants for enum ActiveItem
type
  ActiveItem = TOleEnum;
const
  RosterItem = $00000000;
  Bookmark = $00000001;
  Group = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IExodusController = interface;
  IExodusControllerDisp = dispinterface;
  IExodusChat = interface;
  IExodusChatDisp = dispinterface;
  IExodusPlugin = interface;
  IExodusPluginDisp = dispinterface;
  IExodusChatPlugin = interface;
  IExodusChatPluginDisp = dispinterface;
  IExodusRoster = interface;
  IExodusRosterDisp = dispinterface;
  IExodusPPDB = interface;
  IExodusPPDBDisp = dispinterface;
  IExodusRosterItem = interface;
  IExodusRosterItemDisp = dispinterface;
  IExodusPresence = interface;
  IExodusPresenceDisp = dispinterface;
  IExodusAuth = interface;
  IExodusAuthDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ExodusController = IExodusController;
  ExodusChat = IExodusChat;
  ExodusRoster = IExodusRoster;
  ExodusPPDB = IExodusPPDB;
  ExodusRosterItem = IExodusRosterItem;
  ExodusPresence = IExodusPresence;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PWideString1 = ^WideString; {*}


// *********************************************************************//
// Interface: IExodusController
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {47213401-DAB2-4560-82F7-E5AB15C34397}
// *********************************************************************//
  IExodusController = interface(IDispatch)
    ['{47213401-DAB2-4560-82F7-E5AB15C34397}']
    function Get_Connected: WordBool; safecall;
    function Get_Username: WideString; safecall;
    function Get_Server: WideString; safecall;
    function RegisterCallback(const xpath: WideString; const callback: IExodusPlugin): Integer; safecall;
    procedure UnRegisterCallback(ID: Integer); safecall;
    procedure Send(const xml: WideString); safecall;
    function isRosterJID(const jid: WideString): WordBool; safecall;
    function isSubscribed(const jid: WideString): WordBool; safecall;
    procedure ChangePresence(const Show: WideString; const Status: WideString; Priority: Integer); safecall;
    procedure StartChat(const jid: WideString; const resource: WideString; 
                        const nickname: WideString); safecall;
    procedure GetProfile(const jid: WideString); safecall;
    procedure CreateDockableWindow(HWND: Integer; const Caption: WideString); safecall;
    function addPluginMenu(const Caption: WideString): WideString; safecall;
    procedure removePluginMenu(const ID: WideString); safecall;
    procedure monitorImplicitRegJID(const JabberID: WideString; FullJID: WordBool); safecall;
    procedure getAgentList(const Server: WideString); safecall;
    function getAgentService(const Server: WideString; const Service: WideString): WideString; safecall;
    function generateID: WideString; safecall;
    function isBlocked(const JabberID: WideString): WordBool; safecall;
    procedure Block(const JabberID: WideString); safecall;
    procedure UnBlock(const JabberID: WideString); safecall;
    function Get_resource: WideString; safecall;
    function Get_Port: Integer; safecall;
    function Get_Priority: Integer; safecall;
    function Get_PresenceStatus: WideString; safecall;
    function Get_PresenceShow: WideString; safecall;
    function Get_IsPaused: WordBool; safecall;
    function Get_IsInvisible: WordBool; safecall;
    procedure Connect; safecall;
    procedure Disconnect; safecall;
    function getPrefAsString(const Key: WideString): WideString; safecall;
    function getPrefAsInt(const Key: WideString): Integer; safecall;
    function getPrefAsBool(const Key: WideString): WordBool; safecall;
    procedure setPrefAsString(const Key: WideString; const Value: WideString); safecall;
    procedure setPrefAsInt(const Key: WideString; Value: Integer); safecall;
    procedure setPrefAsBool(const Key: WideString; Value: WordBool); safecall;
    function findChat(const JabberID: WideString; const resource: WideString): Integer; safecall;
    procedure startSearch(const SearchJID: WideString); safecall;
    procedure startRoom(const RoomJID: WideString; const nickname: WideString; 
                        const Password: WideString); safecall;
    procedure startInstantMsg(const JabberID: WideString); safecall;
    procedure startBrowser(const BrowseJID: WideString); safecall;
    procedure showJoinRoom(const RoomJID: WideString; const nickname: WideString; 
                           const Password: WideString); safecall;
    procedure showPrefs; safecall;
    procedure showCustomPresDialog; safecall;
    procedure showDebug; safecall;
    procedure showLogin; safecall;
    procedure showToast(const Message: WideString; wndHandle: Integer; imageIndex: Integer); safecall;
    procedure setPresence(const Show: WideString; const Status: WideString; Priority: Integer); safecall;
    function Get_Roster: IExodusRoster; safecall;
    function Get_PPDB: IExodusPPDB; safecall;
    function registerBrowseNS(const Namespace: WideString): WideString; safecall;
    function registerDiscoItem(const JabberID: WideString; const Name: WideString): WideString; safecall;
    function registerDiscoFeature(const Feature: WideString): WideString; safecall;
    procedure removeBrowseNS(const ID: WideString); safecall;
    procedure removeDiscoItem(const ID: WideString); safecall;
    procedure removeDiscoFeature(const ID: WideString); safecall;
    function registerPresenceXML(const xml: WideString): WideString; safecall;
    procedure removePresenceXML(const ID: WideString); safecall;
    procedure trackWindowsMsg(Message: Integer); safecall;
    function addContactMenu(const Caption: WideString): WideString; safecall;
    procedure removeContactMenu(const ID: WideString); safecall;
    function getActiveContact: WideString; safecall;
    function getActiveGroup: WideString; safecall;
    function getActiveContacts(Online: WordBool): WideString; safecall;
    function Get_LocalIP: WideString; safecall;
    procedure setPluginAuth(const AuthAgent: IExodusAuth); safecall;
    procedure setAuthenticated(Authed: WordBool; const xml: WideString); safecall;
    procedure setAuthJID(const Username: WideString; const Host: WideString; 
                         const resource: WideString); safecall;
    function addMessageMenu(const Caption: WideString): WideString; safecall;
    property Connected: WordBool read Get_Connected;
    property Username: WideString read Get_Username;
    property Server: WideString read Get_Server;
    property resource: WideString read Get_resource;
    property Port: Integer read Get_Port;
    property Priority: Integer read Get_Priority;
    property PresenceStatus: WideString read Get_PresenceStatus;
    property PresenceShow: WideString read Get_PresenceShow;
    property IsPaused: WordBool read Get_IsPaused;
    property IsInvisible: WordBool read Get_IsInvisible;
    property Roster: IExodusRoster read Get_Roster;
    property PPDB: IExodusPPDB read Get_PPDB;
    property LocalIP: WideString read Get_LocalIP;
  end;

// *********************************************************************//
// DispIntf:  IExodusControllerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {47213401-DAB2-4560-82F7-E5AB15C34397}
// *********************************************************************//
  IExodusControllerDisp = dispinterface
    ['{47213401-DAB2-4560-82F7-E5AB15C34397}']
    property Connected: WordBool readonly dispid 1;
    property Username: WideString readonly dispid 2;
    property Server: WideString readonly dispid 3;
    function RegisterCallback(const xpath: WideString; const callback: IExodusPlugin): Integer; dispid 4;
    procedure UnRegisterCallback(ID: Integer); dispid 5;
    procedure Send(const xml: WideString); dispid 6;
    function isRosterJID(const jid: WideString): WordBool; dispid 7;
    function isSubscribed(const jid: WideString): WordBool; dispid 8;
    procedure ChangePresence(const Show: WideString; const Status: WideString; Priority: Integer); dispid 11;
    procedure StartChat(const jid: WideString; const resource: WideString; 
                        const nickname: WideString); dispid 12;
    procedure GetProfile(const jid: WideString); dispid 13;
    procedure CreateDockableWindow(HWND: Integer; const Caption: WideString); dispid 16;
    function addPluginMenu(const Caption: WideString): WideString; dispid 14;
    procedure removePluginMenu(const ID: WideString); dispid 15;
    procedure monitorImplicitRegJID(const JabberID: WideString; FullJID: WordBool); dispid 17;
    procedure getAgentList(const Server: WideString); dispid 18;
    function getAgentService(const Server: WideString; const Service: WideString): WideString; dispid 19;
    function generateID: WideString; dispid 20;
    function isBlocked(const JabberID: WideString): WordBool; dispid 21;
    procedure Block(const JabberID: WideString); dispid 22;
    procedure UnBlock(const JabberID: WideString); dispid 23;
    property resource: WideString readonly dispid 24;
    property Port: Integer readonly dispid 25;
    property Priority: Integer readonly dispid 26;
    property PresenceStatus: WideString readonly dispid 28;
    property PresenceShow: WideString readonly dispid 29;
    property IsPaused: WordBool readonly dispid 30;
    property IsInvisible: WordBool readonly dispid 31;
    procedure Connect; dispid 32;
    procedure Disconnect; dispid 33;
    function getPrefAsString(const Key: WideString): WideString; dispid 34;
    function getPrefAsInt(const Key: WideString): Integer; dispid 35;
    function getPrefAsBool(const Key: WideString): WordBool; dispid 36;
    procedure setPrefAsString(const Key: WideString; const Value: WideString); dispid 37;
    procedure setPrefAsInt(const Key: WideString; Value: Integer); dispid 38;
    procedure setPrefAsBool(const Key: WideString; Value: WordBool); dispid 39;
    function findChat(const JabberID: WideString; const resource: WideString): Integer; dispid 40;
    procedure startSearch(const SearchJID: WideString); dispid 41;
    procedure startRoom(const RoomJID: WideString; const nickname: WideString; 
                        const Password: WideString); dispid 42;
    procedure startInstantMsg(const JabberID: WideString); dispid 43;
    procedure startBrowser(const BrowseJID: WideString); dispid 44;
    procedure showJoinRoom(const RoomJID: WideString; const nickname: WideString; 
                           const Password: WideString); dispid 45;
    procedure showPrefs; dispid 46;
    procedure showCustomPresDialog; dispid 47;
    procedure showDebug; dispid 48;
    procedure showLogin; dispid 49;
    procedure showToast(const Message: WideString; wndHandle: Integer; imageIndex: Integer); dispid 50;
    procedure setPresence(const Show: WideString; const Status: WideString; Priority: Integer); dispid 51;
    property Roster: IExodusRoster readonly dispid 54;
    property PPDB: IExodusPPDB readonly dispid 55;
    function registerBrowseNS(const Namespace: WideString): WideString; dispid 9;
    function registerDiscoItem(const JabberID: WideString; const Name: WideString): WideString; dispid 10;
    function registerDiscoFeature(const Feature: WideString): WideString; dispid 27;
    procedure removeBrowseNS(const ID: WideString); dispid 52;
    procedure removeDiscoItem(const ID: WideString); dispid 53;
    procedure removeDiscoFeature(const ID: WideString); dispid 56;
    function registerPresenceXML(const xml: WideString): WideString; dispid 57;
    procedure removePresenceXML(const ID: WideString); dispid 58;
    procedure trackWindowsMsg(Message: Integer); dispid 59;
    function addContactMenu(const Caption: WideString): WideString; dispid 60;
    procedure removeContactMenu(const ID: WideString); dispid 61;
    function getActiveContact: WideString; dispid 62;
    function getActiveGroup: WideString; dispid 63;
    function getActiveContacts(Online: WordBool): WideString; dispid 65;
    property LocalIP: WideString readonly dispid 64;
    procedure setPluginAuth(const AuthAgent: IExodusAuth); dispid 66;
    procedure setAuthenticated(Authed: WordBool; const xml: WideString); dispid 67;
    procedure setAuthJID(const Username: WideString; const Host: WideString; 
                         const resource: WideString); dispid 68;
    function addMessageMenu(const Caption: WideString): WideString; dispid 201;
  end;

// *********************************************************************//
// Interface: IExodusChat
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {27176DA5-4EEB-442F-9B1F-D25EF948B9CB}
// *********************************************************************//
  IExodusChat = interface(IDispatch)
    ['{27176DA5-4EEB-442F-9B1F-D25EF948B9CB}']
    function Get_jid: WideString; safecall;
    function AddContextMenu(const Caption: WideString): WideString; safecall;
    function Get_MsgOutText: WideString; safecall;
    function RegisterPlugin(const Plugin: IExodusChatPlugin): Integer; safecall;
    function UnRegister(ID: Integer): WordBool; safecall;
    function getMagicInt(Part: ChatParts): Integer; safecall;
    procedure RemoveContextMenu(const ID: WideString); safecall;
    procedure AddMsgOut(const Value: WideString); safecall;
    property jid: WideString read Get_jid;
    property MsgOutText: WideString read Get_MsgOutText;
  end;

// *********************************************************************//
// DispIntf:  IExodusChatDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {27176DA5-4EEB-442F-9B1F-D25EF948B9CB}
// *********************************************************************//
  IExodusChatDisp = dispinterface
    ['{27176DA5-4EEB-442F-9B1F-D25EF948B9CB}']
    property jid: WideString readonly dispid 1;
    function AddContextMenu(const Caption: WideString): WideString; dispid 2;
    property MsgOutText: WideString readonly dispid 4;
    function RegisterPlugin(const Plugin: IExodusChatPlugin): Integer; dispid 3;
    function UnRegister(ID: Integer): WordBool; dispid 5;
    function getMagicInt(Part: ChatParts): Integer; dispid 6;
    procedure RemoveContextMenu(const ID: WideString); dispid 7;
    procedure AddMsgOut(const Value: WideString); dispid 201;
  end;

// *********************************************************************//
// Interface: IExodusPlugin
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72470D1C-9A66-4735-A7CF-446F43561C92}
// *********************************************************************//
  IExodusPlugin = interface(IDispatch)
    ['{72470D1C-9A66-4735-A7CF-446F43561C92}']
    procedure Startup(const ExodusController: IExodusController); safecall;
    procedure Shutdown; safecall;
    procedure Process(const xpath: WideString; const event: WideString; const xml: WideString); safecall;
    procedure NewChat(const jid: WideString; const Chat: IExodusChat); safecall;
    procedure NewRoom(const jid: WideString; const Room: IExodusChat); safecall;
    function NewIM(const jid: WideString; var Body: WideString; var Subject: WideString; 
                   const XTags: WideString): WideString; safecall;
    procedure Configure; safecall;
    procedure MenuClick(const ID: WideString); safecall;
    procedure MsgMenuClick(const ID: WideString; const jid: WideString; var Body: WideString; 
                           var Subject: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IExodusPluginDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72470D1C-9A66-4735-A7CF-446F43561C92}
// *********************************************************************//
  IExodusPluginDisp = dispinterface
    ['{72470D1C-9A66-4735-A7CF-446F43561C92}']
    procedure Startup(const ExodusController: IExodusController); dispid 1;
    procedure Shutdown; dispid 2;
    procedure Process(const xpath: WideString; const event: WideString; const xml: WideString); dispid 3;
    procedure NewChat(const jid: WideString; const Chat: IExodusChat); dispid 4;
    procedure NewRoom(const jid: WideString; const Room: IExodusChat); dispid 5;
    function NewIM(const jid: WideString; var Body: WideString; var Subject: WideString; 
                   const XTags: WideString): WideString; dispid 8;
    procedure Configure; dispid 12;
    procedure MenuClick(const ID: WideString); dispid 201;
    procedure MsgMenuClick(const ID: WideString; const jid: WideString; var Body: WideString; 
                           var Subject: WideString); dispid 202;
  end;

// *********************************************************************//
// Interface: IExodusChatPlugin
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2C576B16-DD6A-4E8C-8DEB-38E255B48A88}
// *********************************************************************//
  IExodusChatPlugin = interface(IDispatch)
    ['{2C576B16-DD6A-4E8C-8DEB-38E255B48A88}']
    procedure onBeforeMessage(var Body: WideString); safecall;
    function onAfterMessage(var Body: WideString): WideString; safecall;
    procedure onKeyPress(const Key: WideString); safecall;
    procedure onContextMenu(const ID: WideString); safecall;
    procedure onRecvMessage(const Body: WideString; const xml: WideString); safecall;
    procedure onClose; safecall;
    procedure onMenu(const ID: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IExodusChatPluginDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2C576B16-DD6A-4E8C-8DEB-38E255B48A88}
// *********************************************************************//
  IExodusChatPluginDisp = dispinterface
    ['{2C576B16-DD6A-4E8C-8DEB-38E255B48A88}']
    procedure onBeforeMessage(var Body: WideString); dispid 1;
    function onAfterMessage(var Body: WideString): WideString; dispid 2;
    procedure onKeyPress(const Key: WideString); dispid 3;
    procedure onContextMenu(const ID: WideString); dispid 4;
    procedure onRecvMessage(const Body: WideString; const xml: WideString); dispid 5;
    procedure onClose; dispid 6;
    procedure onMenu(const ID: WideString); dispid 201;
  end;

// *********************************************************************//
// Interface: IExodusRoster
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {29B1C26F-2F13-47D8-91C4-A4A5AC43F4A9}
// *********************************************************************//
  IExodusRoster = interface(IDispatch)
    ['{29B1C26F-2F13-47D8-91C4-A4A5AC43F4A9}']
    procedure Fetch; safecall;
    procedure SaveBookmarks; safecall;
    procedure AddItem(const JabberID: WideString; const nickname: WideString; 
                      const Group: WideString; Subscribe: WordBool); safecall;
    procedure AddBookmark(const JabberID: WideString; const bmType: WideString; 
                          const bmName: WideString; const nickname: WideString; AutoJoin: WordBool); safecall;
    procedure RemoveBookmark(const JabberID: WideString); safecall;
    function Find(const JabberID: WideString): IExodusRosterItem; safecall;
    function Item(Index: Integer): IExodusRosterItem; safecall;
    function Count: Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IExodusRosterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {29B1C26F-2F13-47D8-91C4-A4A5AC43F4A9}
// *********************************************************************//
  IExodusRosterDisp = dispinterface
    ['{29B1C26F-2F13-47D8-91C4-A4A5AC43F4A9}']
    procedure Fetch; dispid 1;
    procedure SaveBookmarks; dispid 2;
    procedure AddItem(const JabberID: WideString; const nickname: WideString; 
                      const Group: WideString; Subscribe: WordBool); dispid 3;
    procedure AddBookmark(const JabberID: WideString; const bmType: WideString; 
                          const bmName: WideString; const nickname: WideString; AutoJoin: WordBool); dispid 4;
    procedure RemoveBookmark(const JabberID: WideString); dispid 5;
    function Find(const JabberID: WideString): IExodusRosterItem; dispid 6;
    function Item(Index: Integer): IExodusRosterItem; dispid 7;
    function Count: Integer; dispid 8;
  end;

// *********************************************************************//
// Interface: IExodusPPDB
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {284E49F2-2006-4E48-B0E0-233867A78E54}
// *********************************************************************//
  IExodusPPDB = interface(IDispatch)
    ['{284E49F2-2006-4E48-B0E0-233867A78E54}']
    function Find(const JabberID: WideString; const resource: WideString): IExodusPresence; safecall;
    function Next(const JabberID: WideString; const resource: WideString): IExodusPresence; safecall;
    function Get_Count: Integer; safecall;
    function Get_LastPresence: IExodusPresence; safecall;
    property Count: Integer read Get_Count;
    property LastPresence: IExodusPresence read Get_LastPresence;
  end;

// *********************************************************************//
// DispIntf:  IExodusPPDBDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {284E49F2-2006-4E48-B0E0-233867A78E54}
// *********************************************************************//
  IExodusPPDBDisp = dispinterface
    ['{284E49F2-2006-4E48-B0E0-233867A78E54}']
    function Find(const JabberID: WideString; const resource: WideString): IExodusPresence; dispid 1;
    function Next(const JabberID: WideString; const resource: WideString): IExodusPresence; dispid 2;
    property Count: Integer readonly dispid 3;
    property LastPresence: IExodusPresence readonly dispid 4;
  end;

// *********************************************************************//
// Interface: IExodusRosterItem
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F710F80C-C74A-4A69-8D2B-023504125B96}
// *********************************************************************//
  IExodusRosterItem = interface(IDispatch)
    ['{F710F80C-C74A-4A69-8D2B-023504125B96}']
    function Get_JabberID: WideString; safecall;
    procedure Set_JabberID(const Value: WideString); safecall;
    function Get_Subscription: WideString; safecall;
    procedure Set_Subscription(const Value: WideString); safecall;
    function Get_Ask: WideString; safecall;
    function Get_GroupCount: Integer; safecall;
    function Group(Index: Integer): WideString; safecall;
    function xml: WideString; safecall;
    procedure Remove; safecall;
    procedure Update; safecall;
    function Get_nickname: WideString; safecall;
    procedure Set_nickname(const Value: WideString); safecall;
    function Get_RawNickname: WideString; safecall;
    property JabberID: WideString read Get_JabberID write Set_JabberID;
    property Subscription: WideString read Get_Subscription write Set_Subscription;
    property Ask: WideString read Get_Ask;
    property GroupCount: Integer read Get_GroupCount;
    property nickname: WideString read Get_nickname write Set_nickname;
    property RawNickname: WideString read Get_RawNickname;
  end;

// *********************************************************************//
// DispIntf:  IExodusRosterItemDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F710F80C-C74A-4A69-8D2B-023504125B96}
// *********************************************************************//
  IExodusRosterItemDisp = dispinterface
    ['{F710F80C-C74A-4A69-8D2B-023504125B96}']
    property JabberID: WideString dispid 1;
    property Subscription: WideString dispid 2;
    property Ask: WideString readonly dispid 4;
    property GroupCount: Integer readonly dispid 5;
    function Group(Index: Integer): WideString; dispid 6;
    function xml: WideString; dispid 7;
    procedure Remove; dispid 8;
    procedure Update; dispid 9;
    property nickname: WideString dispid 10;
    property RawNickname: WideString readonly dispid 11;
  end;

// *********************************************************************//
// Interface: IExodusPresence
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D2FD3425-40CE-469F-A95C-1C80B7FF3119}
// *********************************************************************//
  IExodusPresence = interface(IDispatch)
    ['{D2FD3425-40CE-469F-A95C-1C80B7FF3119}']
    function Get_PresType: WideString; safecall;
    procedure Set_PresType(const Value: WideString); safecall;
    function Get_Status: WideString; safecall;
    procedure Set_Status(const Value: WideString); safecall;
    function Get_Show: WideString; safecall;
    procedure Set_Show(const Value: WideString); safecall;
    function Get_Priority: Integer; safecall;
    procedure Set_Priority(Value: Integer); safecall;
    function Get_ErrorString: WideString; safecall;
    procedure Set_ErrorString(const Value: WideString); safecall;
    function xml: WideString; safecall;
    function isSubscription: WordBool; safecall;
    function Get_toJid: WideString; safecall;
    procedure Set_toJid(const Value: WideString); safecall;
    function Get_fromJid: WideString; safecall;
    procedure Set_fromJid(const Value: WideString); safecall;
    property PresType: WideString read Get_PresType write Set_PresType;
    property Status: WideString read Get_Status write Set_Status;
    property Show: WideString read Get_Show write Set_Show;
    property Priority: Integer read Get_Priority write Set_Priority;
    property ErrorString: WideString read Get_ErrorString write Set_ErrorString;
    property toJid: WideString read Get_toJid write Set_toJid;
    property fromJid: WideString read Get_fromJid write Set_fromJid;
  end;

// *********************************************************************//
// DispIntf:  IExodusPresenceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D2FD3425-40CE-469F-A95C-1C80B7FF3119}
// *********************************************************************//
  IExodusPresenceDisp = dispinterface
    ['{D2FD3425-40CE-469F-A95C-1C80B7FF3119}']
    property PresType: WideString dispid 1;
    property Status: WideString dispid 2;
    property Show: WideString dispid 3;
    property Priority: Integer dispid 4;
    property ErrorString: WideString dispid 5;
    function xml: WideString; dispid 6;
    function isSubscription: WordBool; dispid 7;
    property toJid: WideString dispid 8;
    property fromJid: WideString dispid 9;
  end;

// *********************************************************************//
// Interface: IExodusAuth
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D33EA5B9-23FD-4E43-B5B7-3CCFD0F5CDD0}
// *********************************************************************//
  IExodusAuth = interface(IDispatch)
    ['{D33EA5B9-23FD-4E43-B5B7-3CCFD0F5CDD0}']
    procedure StartAuth; safecall;
    procedure CancelAuth; safecall;
    function StartRegistration: WordBool; safecall;
    procedure CancelRegistration; safecall;
  end;

// *********************************************************************//
// DispIntf:  IExodusAuthDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D33EA5B9-23FD-4E43-B5B7-3CCFD0F5CDD0}
// *********************************************************************//
  IExodusAuthDisp = dispinterface
    ['{D33EA5B9-23FD-4E43-B5B7-3CCFD0F5CDD0}']
    procedure StartAuth; dispid 1;
    procedure CancelAuth; dispid 2;
    function StartRegistration: WordBool; dispid 3;
    procedure CancelRegistration; dispid 4;
  end;

// *********************************************************************//
// The Class CoExodusController provides a Create and CreateRemote method to          
// create instances of the default interface IExodusController exposed by              
// the CoClass ExodusController. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoExodusController = class
    class function Create: IExodusController;
    class function CreateRemote(const MachineName: string): IExodusController;
  end;

// *********************************************************************//
// The Class CoExodusChat provides a Create and CreateRemote method to          
// create instances of the default interface IExodusChat exposed by              
// the CoClass ExodusChat. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoExodusChat = class
    class function Create: IExodusChat;
    class function CreateRemote(const MachineName: string): IExodusChat;
  end;

// *********************************************************************//
// The Class CoExodusRoster provides a Create and CreateRemote method to          
// create instances of the default interface IExodusRoster exposed by              
// the CoClass ExodusRoster. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoExodusRoster = class
    class function Create: IExodusRoster;
    class function CreateRemote(const MachineName: string): IExodusRoster;
  end;

// *********************************************************************//
// The Class CoExodusPPDB provides a Create and CreateRemote method to          
// create instances of the default interface IExodusPPDB exposed by              
// the CoClass ExodusPPDB. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoExodusPPDB = class
    class function Create: IExodusPPDB;
    class function CreateRemote(const MachineName: string): IExodusPPDB;
  end;

// *********************************************************************//
// The Class CoExodusRosterItem provides a Create and CreateRemote method to          
// create instances of the default interface IExodusRosterItem exposed by              
// the CoClass ExodusRosterItem. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoExodusRosterItem = class
    class function Create: IExodusRosterItem;
    class function CreateRemote(const MachineName: string): IExodusRosterItem;
  end;

// *********************************************************************//
// The Class CoExodusPresence provides a Create and CreateRemote method to          
// create instances of the default interface IExodusPresence exposed by              
// the CoClass ExodusPresence. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoExodusPresence = class
    class function Create: IExodusPresence;
    class function CreateRemote(const MachineName: string): IExodusPresence;
  end;

implementation

uses ComObj;

class function CoExodusController.Create: IExodusController;
begin
  Result := CreateComObject(CLASS_ExodusController) as IExodusController;
end;

class function CoExodusController.CreateRemote(const MachineName: string): IExodusController;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExodusController) as IExodusController;
end;

class function CoExodusChat.Create: IExodusChat;
begin
  Result := CreateComObject(CLASS_ExodusChat) as IExodusChat;
end;

class function CoExodusChat.CreateRemote(const MachineName: string): IExodusChat;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExodusChat) as IExodusChat;
end;

class function CoExodusRoster.Create: IExodusRoster;
begin
  Result := CreateComObject(CLASS_ExodusRoster) as IExodusRoster;
end;

class function CoExodusRoster.CreateRemote(const MachineName: string): IExodusRoster;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExodusRoster) as IExodusRoster;
end;

class function CoExodusPPDB.Create: IExodusPPDB;
begin
  Result := CreateComObject(CLASS_ExodusPPDB) as IExodusPPDB;
end;

class function CoExodusPPDB.CreateRemote(const MachineName: string): IExodusPPDB;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExodusPPDB) as IExodusPPDB;
end;

class function CoExodusRosterItem.Create: IExodusRosterItem;
begin
  Result := CreateComObject(CLASS_ExodusRosterItem) as IExodusRosterItem;
end;

class function CoExodusRosterItem.CreateRemote(const MachineName: string): IExodusRosterItem;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExodusRosterItem) as IExodusRosterItem;
end;

class function CoExodusPresence.Create: IExodusPresence;
begin
  Result := CreateComObject(CLASS_ExodusPresence) as IExodusPresence;
end;

class function CoExodusPresence.CreateRemote(const MachineName: string): IExodusPresence;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExodusPresence) as IExodusPresence;
end;

end.

unit TelegramBotApi.Types.Intf;

interface

type
  ItgUser = interface
    ['{36E2D7DC-AD07-4290-A61A-A7D73132158C}']
    function GetCanJoinGroups: Boolean;
    function GetCanReadAllGroupMessages: Boolean;
    function GetFirstName: string;
    function GetID: Int64;
    function GetIsBot: Boolean;
    function GetLanguageCode: string;
    function GetLastName: string;
    function GetSupportsInlineQueries: Boolean;
    function GetUsername: string;
    // public
    property CanJoinGroups: Boolean read GetCanJoinGroups;
    property CanReadAllGroupMessages: Boolean read GetCanReadAllGroupMessages;
    property FirstName: string read GetFirstName;
    property ID: Int64 read GetID;
    property IsBot: Boolean read GetIsBot;
    property LanguageCode: string read GetLanguageCode;
    property LastName: string read GetLastName;
    property SupportsInlineQueries: Boolean read GetSupportsInlineQueries;
    property Username: string read GetUsername;
  end;

implementation

end.

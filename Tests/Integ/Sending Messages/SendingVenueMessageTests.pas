unit SendingVenueMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TSendingVenueMessageTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Send_Venue;
  end;

implementation

uses
  Test.Assert,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums, System.SysUtils;

procedure TSendingVenueMessageTests.Should_Send_Venue;
const
  title = 'Rubirosa Ristorante';
  address = '235 Mulberry St';
  lat = 40.722728;
  lon = -73.996006;
  foursquareId = '4cc6222106c25481d7a4a047';
var
  LVenueArgument: TtgSendVenueArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LVenueArgument := TtgSendVenueArgument.Default;
  LVenueArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LVenueArgument.Latitude := lat;
  LVenueArgument.Longitude := lon;
  LVenueArgument.title := title;
  LVenueArgument.address := address;
  LVenueArgument.foursquareId := foursquareId;
  LResult := Bot.SendVenue(LVenueArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;
  Assert.AreEqual(TtgMessageType.Venue, LMessage.&Type);
  Assert.AreEqual(LVenueArgument.title, LMessage.Venue.title);
  Assert.AreEqual(LVenueArgument.address, LMessage.Venue.address);
  Assert.AreEqual(LVenueArgument.foursquareId, LMessage.Venue.foursquareId);
  TgAssert.InRange(LMessage.Venue.Location.Longitude, lon - 0.001, lon + 0.001);
  TgAssert.InRange(LMessage.Venue.Location.Latitude, lat - 0.001, lat + 0.001);
end;

end.

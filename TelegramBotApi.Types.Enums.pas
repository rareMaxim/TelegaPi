unit TelegramBotApi.Types.Enums;

interface

type
{$SCOPEDENUMS ON}
  /// <summary>
  /// The type of a Message
  /// </summary>
  TtgMessageType = (Unknown = 0, Text, Photo, Audio, Video, VideoNote, Voice, Document, Sticker, Game,
    Location, Contact, Service, Venue);

  TtgParseMode = (Default, Markdown, MarkdownV2, HTML);

  /// <summary>
  /// The type of an Update
  /// </summary>
  TtgUpdateType = (
    /// <summary>
    /// Update Type is unknown
    /// </summary>
    UnknownUpdate = 0,

    /// <summary>
    /// The <see cref="Update" /> contains a <see cref="Message" />.
    /// </summary>
    MessageUpdate,

    /// <summary>
    /// The <see cref="Update" /> contains an <see cref="InlineQuery" />.
    /// </summary>
    InlineQueryUpdate,

    /// <summary>
    /// The <see cref="Update" /> contains a <see cref="ChosenInlineResult" />
    /// </summary>
    ChosenInlineResultUpdate,

    /// <summary>
    /// The <see cref="Update" /> contins a <see cref="CallbackQuery" />
    /// </summary>
    CallbackQueryUpdate,

    /// <summary>
    /// The <see cref="Update" /> contains an edited <see cref="Message" />
    /// </summary>
    EditedMessage,

    /// <summary>
    /// The <see cref="Update" /> contains a channel post <see cref="Message" />
    /// </summary>
    ChannelPost,

    /// <summary>
    /// The <see cref="Update" /> contains an edited channel post <see cref="Message" />
    /// </summary>
    EditedChannelPost,

    /// <summary>
    /// The <see cref="Update" /> contains an <see cref="ShippingQueryUpdate" />
    /// </summary>
    ShippingQueryUpdate,

    /// <summary>
    /// The <see cref="Update" /> contains an <see cref="PreCheckoutQueryUpdate" />
    /// </summary>
    PreCheckoutQueryUpdate,

    /// <summary>
    /// Receive all <see cref="Update" /> Types
    /// </summary>
    All = 255);
{$SCOPEDENUMS OFF}
  TAllowedUpdate = (message, Edited_message, Channel_post, Edited_channel_post, Inline_query,
    Chosen_inline_result, Callback_query);
  TAllowedUpdates = set of TAllowedUpdate;

const
  UPDATES_ALLOWED_ALL = [Low(TAllowedUpdate) .. High(TAllowedUpdate)];
  TG_PARSE_MODES: array of string = ['', 'Markdown', 'MarkdownV2', 'HTML'];

implementation

end.

unit Test.Constants;

interface

type
  TtgConst = class
  public type
    PathToFile = class

    public const
      FilesDir: string = 'Files/';
    public type
      Videos = class
        class function VideoDir: string;
        class function GoldenRatio: string;
        class function MoonLanding: string;
      end;

      Thumbnail = class
      private
        class function Dir: string;
      public
        class function Video: string;
        class function TheAbilityToBreak: string;
      end;

      Photos = class
      private
        class function PhotoDir: string;
      public
        class function Bot: string;
        class function Logo: string;
      end;

      Documents = class
      private
        class function DocumentDir: string;
      public
        class function Hamlet: string;
      end;

      Audio = class
      private
        class function AudioDir: string;
      public
        class function AStateOfDespairMp3: string;
        class function CantinaRagMp3: string;
        class function TestOgg: string;
      end;
    end;
  public

    // class function PathToFile: TtgPathToFile;
  end;

implementation

{ TtgConst.PathToFile.Videos }

class function TtgConst.PathToFile.Videos.GoldenRatio: string;
begin
  Result := VideoDir + 'golden-ratio-240px.mp4';
end;

class function TtgConst.PathToFile.Videos.MoonLanding: string;
begin
  Result := VideoDir + 'moon-landing.mp4';
end;

class function TtgConst.PathToFile.Videos.VideoDir: string;
begin
  Result := PathToFile.FilesDir + 'Video/';
end;

{ TtgConst.PathToFile.Thumbnail }

class function TtgConst.PathToFile.Thumbnail.Dir: string;
begin
  Result := PathToFile.FilesDir + 'Thumbnail/';
end;

class function TtgConst.PathToFile.Thumbnail.TheAbilityToBreak: string;
begin
  Result := Dir + 'The Ability to Break.jpg';
end;

class function TtgConst.PathToFile.Thumbnail.Video: string;
begin
  Result := Dir + 'video.jpg';
end;

{ TtgConst.PathToFile.Photos }

class function TtgConst.PathToFile.Photos.Bot: string;
begin
  Result := PhotoDir + 'bot.gif';
end;

class function TtgConst.PathToFile.Photos.Logo: string;
begin
  Result := PhotoDir + 'logo.png';
end;

class function TtgConst.PathToFile.Photos.PhotoDir: string;
begin
  Result := FilesDir + 'Photo/';
end;

{ TtgConst.PathToFile.Documents }

class function TtgConst.PathToFile.Documents.DocumentDir: string;
begin
  Result := FilesDir + 'Document/';
end;

class function TtgConst.PathToFile.Documents.Hamlet: string;
begin
  Result := DocumentDir + 'hamlet.pdf';
end;

{ TtgConst.PathToFile.Audio }

class function TtgConst.PathToFile.Audio.AStateOfDespairMp3: string;
begin
  Result := AudioDir + 'Ask Again - A State of Despair.mp3';
end;

class function TtgConst.PathToFile.Audio.AudioDir: string;
begin
  Result := FilesDir + 'Audio/';
end;

class function TtgConst.PathToFile.Audio.CantinaRagMp3: string;
begin
  Result := AudioDir + 'Jackson F Smith - Cantina Rag.mp3';
end;

class function TtgConst.PathToFile.Audio.TestOgg: string;
begin
  Result := AudioDir + 'Test.ogg';
end;

end.

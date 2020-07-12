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

end.

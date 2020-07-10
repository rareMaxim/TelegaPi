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

end.

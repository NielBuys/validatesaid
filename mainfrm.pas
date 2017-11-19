unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    Button1: TButton;
    IDEdit: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    function ValidateID(ID: String): Boolean;
    function ValidateIDNEW(ID: String): Boolean;
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.Button1Click(Sender: TObject);
begin
     If ValidateID(IDEdit.Text) = true then
     begin
       showmessage('ID is valid Old function');
     end
     else
     begin
       showmessage('ID is not valid Old function');
     end;
     If ValidateIDNEW(IDEdit.Text) = true then
     begin
       showmessage('ID is valid New function');
     end
     else
     begin
       showmessage('ID is not valid New function');
     end;
end;

function TMainForm.ValidateID(ID: String): Boolean;
var
    i1, i2, i3, i4, i5: Integer;
    s: String;
begin

/// http://geekswithblogs.net/willemf/archive/2005/10/30/58561.aspx ///

  ValidateID := True;
  If  Length(ID) = 13 then
  begin
    try
      i1 := StrtoInt(copy(ID,1,1)) + StrtoInt(copy(ID,3,1)) + StrtoInt(copy(ID,5,1)) + StrtoInt(copy(ID,7,1)) + StrtoInt(copy(ID,9,1)) + StrtoInt(copy(ID,11,1));
      i2 := StrtoInt(copy(ID,2,1) + copy(ID,4,1) + copy(ID,6,1) + copy(ID,8,1) + copy(ID,10,1) + copy(ID,12,1)) * 2;
      If Length(InttoStr(i2)) = 5 then
        s := '0' + InttoStr(i2)
      else
      begin
        If Length(InttoStr(i2)) = 4 then
          s := '00' + InttoStr(i2)
        else
        begin
          If Length(InttoStr(i2)) = 3 then
            s := '000' + InttoStr(i2)
          else
            s := InttoStr(i2);
        end;
      end;
      If Length(s) = 6 then
        i3 := StrtoInt(copy(s,1,1)) + StrtoInt(copy(s,2,1)) + StrtoInt(copy(s,3,1)) + StrtoInt(copy(s,4,1)) + StrtoInt(copy(s,5,1)) + StrtoInt(copy(s,6,1))
      else
        i3 := StrtoInt(copy(s,1,1)) + StrtoInt(copy(s,2,1)) + StrtoInt(copy(s,3,1)) + StrtoInt(copy(s,4,1)) + StrtoInt(copy(s,5,1)) + StrtoInt(copy(s,6,1)) + StrtoInt(copy(s,7,1));

      i4 := i1 + i3;
      i5 := 10 - strtoint(copy(InttoStr(i4),2,1));
      If i5 > 9 then
        i5 := 0;
      If copy(ID,13,1) <> InttoStr(i5) then
        ValidateID := False;
    except
      ValidateID := False;
    end;
  end
  else
    ValidateID := False;
end;

function TMainForm.ValidateIDNEW(ID: String): Boolean;
var
    oddValue, evenValue, i, CheckDigit: Integer;
    evenString: String;
begin
  ValidateIDNEW := True;
  If  Length(ID) = 13 then
  begin
    try
      i := 1;
      oddValue := 0;
      while i < 13 do
      begin
        // 1. Add all the digits in the odd positions (excluding last digit).
         oddValue := oddValue + StrtoInt(copy(ID,i,1));
         i := i + 2;
      end;
      i := 2;
      evenString := '';
      while i < 13 do
      begin
        // 2. Move the even positions into a field and multiply the number by 2.
         evenString := evenString + copy(ID,i,1);
         i := i + 2;
      end;
      evenString := InttoStr(StrtoInt(evenString) * 2);

      evenValue := 0;
      for i := 1 to Length(evenString) do
      begin
         // 3. Add the digits of the result in 2.
         evenValue := evenValue + StrtoInt(copy(evenString,i,1));
      end;

      // 4. Add the answer in 1. to the answer in 3.
      i := oddValue + evenValue;

      // 5. Subtract the second digit in 4. from 10.
      CheckDigit := 10 - strtoint(copy(InttoStr(i),2,1));
      If CheckDigit > 9 then
        CheckDigit := 0;
      If copy(ID,13,1) <> InttoStr(CheckDigit) then
        ValidateIDNEW := False;
    except
      ValidateIDNEW := False;
    end;
  end
  else
    ValidateIDNEW := False;
end;

end.


// AiSD5_Z1 Ćwiczenie zaliczeniowe nr 1, v.05, 02.12.2022
// Bagieński Kamil, 155623, 2022/2023, Informatyki, Zarządzania i Transportu, D1, I
program AiSD5_Z1;



function f(x: real) :real;
begin
     result:= x*x
end;
function pierwiastek(a: double; p:double; Eps: double; MaxI: integer; var z:integer) : double;
begin

  Inc(z); // zwiekszanie var z kazdym wywolaniem funkcji
  p:= (p + a / p) / 2.0;
  if (Eps>=abs(p-a/p)) or (z>=MaxI) then
  begin
    Result := p; //jesli zostanie spelniony chociaz jeden warunek zapisz wynik
    end
    else Result := pierwiastek(a,p,Eps,MaxI,z); // poki nie zostanie spelniony warunek przywoluj funkcje na nowo
end;

var
  a,b,Eps,p:double;
  MaxI,n: Integer;
  weryfikacja: char;


procedure metoda_prostokatow (a:double; b:double; n:Integer);
var
  wynik,dx:double;
  i:Integer;
   begin
dx := (b - a) / (n * 1.0);    //  wzor na obliczanie dx

wynik := 0;       //wyzerowanie zmiennej wynik, aby nie miala wartosci 1
for i:=1 to n do
wynik := wynik + f(a + i * dx); //dodaj wynik do przywolanej funkcji, funkcja otzymuje parametr z wyliczenia a+i*dx i potem go poteguje
wynik := wynik *dx; // gdy i=n zapisz wynik
writeln;
writeln('Wartosc calki metoda prostokatow wynosi: ', wynik:0:6);
   end;

procedure metoda_trapezow (a:double; b:double; n:Integer);
var
  wynik,dx:double;
  i:Integer;
   begin
dx := (b - a) / (n * 1.0);

wynik := 0;
for i:=1 to n-1 do
wynik := wynik + f(a + i * dx);
wynik := wynik + ((f(a) + f(b)) / 2);
wynik := wynik *dx;
writeln;
writeln('Wartosc calki metoda trapezow wynosi:    ', wynik:0:6);
   end;

procedure metoda_simpsona (a:double; b:double; n:Integer);
var
  wynik,dx,s,x:double;
  i:Integer;
   begin
        dx := (b - a) / (n * 1.0);

        wynik := 0;
        s := 0;
        for i:=1 to n-1 do
        begin
        x := a + i*dx;
        s := s + f(x - dx / 2);
        wynik := wynik + f(x);
        end;
        s := s + f(b - dx / 2);
        wynik := (dx/6) * (f(a) + f(b) + 2*wynik + 4*s);
writeln;
writeln('Wartosc calki metoda Simpsona wynosi:    ', wynik:0:6);
   end;

procedure metoda_iteracji (a:double; p:double; Eps:double; Maxi:Integer);
  var
    x:double;
    i:Integer;
begin

x:=a/2;
i:=0;
repeat
x:=(p+a/p)/2;
p:=x;
i:=i+1;
if i>=MaxI then //przerwij wczesniej dzialanie petli jesli zostanie spelniony warunek
break;

until Eps>=abs(x-a/x); //przerwij ostatecznie petle jesli dojdzie do dokladnosci

writeln('Piewrwiastek wynosi:         ',x:0:2);
writeln('Ilosc iteracji:              ',i:0);
writeln('Kwadrat obliczonej wartosci: ',x*x:0:2);
writeln('Roznica obliczonej wartosci: ',abs(a-x*x):0:2);// zaokraglenie, bo roznica nie da idealnie rownego wyniku przez to, ze obliczamy do dokladnosci

end;



procedure metoda_rekurencji (a:double; p:double; Eps:double; Maxi:Integer);
var
  x:double;
  z:Integer;
begin
z:=0;    //wyzerowanie zmiennej z
x := pierwiastek(a, p, Eps, MaxI, z); //wywolanie funkcji pierwiastek

writeln('Piewrwiastek wynosi:         ',x:0:2);
writeln('Ilosc rekurencji:            ',z:0);
writeln('Kwadrat obliczonej wartosci: ',x*x:0:2);
writeln('Roznica obliczonej wartosci: ',abs(a-x*x):0:2);


end;

begin   // tutaj zaczyna sie to co widoczne na konsoli
writeln('Program: Cwiczenie zaliczeniowe nr 1');
writeln('Autor: Bagienski Kamil, 155623, 2022/2023, Informatyk, Zarzadzania i Transportu, D1, I');
writeln;
writeln('=============================================');
writeln;
writeln ('Zadanie 2');
writeln ('Obliczanie calki oznaczonej metodami prostokata, trapezu i Simpsona');
writeln ('W przedziale od 1 do 10');
writeln ('Z funkcji f(x)=x*2 z n iloscia podzialow;');
writeln;
weryfikacja:= 'z';
repeat
write('Podaj poczatek przedzialu oznaczone jako a: ');
readln(a);

write('Podaj koniec przedzialu oznaczone jako b: ');
readln(b);

write('Podaj ilosc podzialow n: ');
readln(n);

if (a<1) or (a>10) or (b<1) or (b>10) or (a>b) then // weryfikacja czy uzytkownik podal prawidlowe dane, jesli nie to wraca do podawania danych
begin
writeln;
writeln('Podaj prawidlowy przedzial');
writeln;
end

else

weryfikacja:='k'

until weryfikacja='k';   // zamkniecie petli po wpisaniu prawidlowych danych

metoda_prostokatow(a,b,n);   // wywolanie procedury i pobranie aktualnych wartosci zmiennych
metoda_trapezow(a,b,n);      // wywolanie procedury i pobranie aktualnych wartosci zmiennych
metoda_simpsona(a,b,n);      // wywolanie procedury i pobranie aktualnych wartosci zmiennych


writeln;
writeln('=============================================');
writeln;
writeln('Zadanie 3 i 4');
writeln('Obliczanie  pierwiastka liczby rzeczywistej');
writeln('przy pomocy algorytmu Newtona-Raphsona metoda iteracji i rekurencji');
writeln;
//zbieranie danych do zadania 3 i 4

write('Podaj wartosc liczby rzeczywistej a: ');
readln(a);

write('Podaj wartosc pierwszego przybliczenia p: ');
readln(p);

write('Podaj dokladnosc Eps: ');
readln(Eps);

write('Podaj maksymalna ilosc iteracji/rekurencji: ');
readln(MaxI);

writeln;
writeln('METODA ITERACJI');
writeln;
metoda_iteracji(a,p,Eps,MaxI);     // wywolanie procedury i pobranie aktualnych wartosci zmiennych
writeln;
writeln('--------------------------------------------');
writeln;
writeln('METODA REKURENCJI');
writeln;
metoda_rekurencji(a,p,Eps,MaxI);  // wywolanie procedury i pobranie aktualnych wartosci zmiennych
writeln;
writeln('Wcisnij ENTER aby wyjsc...');

readln;


end.

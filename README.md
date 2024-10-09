# small_logistics
A small TMS program for creating orders and assigning tours to vehicles

Założenia: Aplikacja jest przeznaczona dla małej firmy transportowej, która zajmuje się przewożeniem towarów dla grupy klientów.

Aplikacja składa się z zakładek: Nowe zlecenie Nowa trasa Lista aktywnych tras Archiwum zleceń Archiwum tras

Na zakładce nowe zlecenie można utworzyć nowe zlecenie. Na zakładce Nowa trasa można zadysponować 3 zlecenia na jedno auto. Zlecenia już zadysponowane zostają przeniesione do archiwum i są nie widoczne w wyborze zleceń dla dyspozycji. Na zakładce Lista aktywnych tras - można zobaczyć trasy (zlecenia zadysponowane na samochód), które nie zostały jeszcze wykonane. Gdy trasa zostanie zrealizowana, można zaznaczyć checkbox 'Zrealizowano' co przenosi trasę do archiwum. Na zakładce Archiwum zleceń można zobaczyć, które zlecenia zostały już zadysponowane na samochody. W polu data znajduje się data wprowadzenia zlecenia (data jest wpisywana podczas zakładania zlecenia) Na zakładce Archiwum tras można zobaczyć wszystkie zrealizowane trasy. W polu data znajduje się data zrealizowania danej trasy (data wpisuje się przy zaznaczaniu opcji 'Zrealizowano" na zakładce 'Lista aktywnych tras')

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Zaloguj się jako PostgreSQL: psql -U postgres

Utwórz bazę danych: CREATE DATABASE logistics;

Zaimportuj bazę danych (w cmd): pg_restore -U postgres -d logistics -O C:\ścieżka\do\pliku\backup.sql

W cmd przejdź do ścieżki, w której znajduje się aplikacja i uruchom ją za pomocą: python app.py

Aplikacja dostępna pod adresem http://127.0.0.1:5000/

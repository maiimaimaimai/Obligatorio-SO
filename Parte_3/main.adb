with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main is

   -- Tamaño de memoria y número de CPUs y semáforos
   Mem_Size    : constant Integer := 128;
   CPU_Count   : constant Integer := 2;
   Sem_Count   : constant Integer := 16;

   -- Paquete para manejar números consecutivos para CPUs
   package Counter is
      function Get_Next return Integer;
   private
      Data : Integer := 0;
   end Counter;

   package body Counter is
      function Get_Next return Integer is
      begin
         Data := Data + 1;
         return Data - 1;
      end Get_Next;
   end Counter;

   -- Definición de tarea Semáforo
   task type Semaforo is
      entry Init (Val : Integer);
      entry Wait;
      entry Signal;
   end Semaforo;

   task body Semaforo is
      Value : Integer := 0;
   begin
      loop
         select
            when Value > 0 =>
               accept Wait do
                  Value := Value - 1;
               end Wait;
            or
               accept Signal do
                  Value := Value + 1;
               end Signal;
            or
               accept Init (Val : Integer) do
                  Value := Val;
               end Init;
         end select;
      end loop;
   end Semaforo;

   -- Lista de semáforos
   Semaforos : array (0 .. Sem_Count - 1) of Semaforo;

   -- Tarea Memoria
   task Memoria is
      entry Escribir (Posicion : in Integer; Valor : in Integer);
      entry Leer (Posicion : in Integer; Valor : out Integer);
   end Memoria;

   task body Memoria is
      Mem : array (0 .. Mem_Size - 1) of Integer := (others => 0);
   begin
      loop
         select
            accept Escribir (Posicion : in Integer; Valor : in Integer) do
               Mem(Posicion) := Valor;
            end Escribir;
         or
            accept Leer (Posicion : in Integer; Valor : out Integer) do
               Valor := Mem(Posicion);
            end Leer;
         end select;
      end loop;
   end Memoria;

   -- Tarea CPU
   task type CPU is
      entry Start (ID : Integer);
      entry Stop;
   end CPU;

   task body CPU is
      A  : Integer := 0; -- Acumulador
      -- de 0 a 63 son las instrucciones y de 64 a 127 son los parametros que reciben
      IP : Integer := 64; -- Instruction Pointer
      Valor : Integer := 0;
      Instruccion : Integer;
      Pos : Integer := 0;
      ID : Integer := 0;
      Running : Boolean := True;
   begin
      loop
         select
            accept Start (ID : Integer) do
               Running := True;
               while Running loop
                  Memoria.Leer(IP, Instruccion);
                  case Instruccion is
                  when 0 =>
                     -- LOAD
                     Memoria.Leer(IP - 64, Valor);
                     A := Valor;
                     IP := IP + 1;

                  when 1 =>
                     -- STORE
                     Memoria.Leer(IP - 64, Valor);
                     Memoria.Escribir(Valor, A);
                     IP := IP + 1;

                  when 2 =>
                     -- ADD
                     Memoria.Leer(IP - 64, Valor);
                     A := A + Valor;
                     IP := IP + 1;

                  when 3 =>
                     -- SUB
                     Memoria.Leer(IP - 64, Valor);
                     A := A - Valor;

                  when 4 =>
                     -- BRCPU
                     if ID = IP - 64 then
                        IP := IP + 1;
                     else
                        IP := IP + 2;
                     end if;

                  when 5 =>
                     -- SEMINIT
                     Valor := IP - 64 + 1;
                     Semaforos(IP - 64).Init(Valor);
                     IP := IP + 2;

                  when 6 =>
                     -- SEMWAIT
                     Semaforos(IP - 64).Wait;
                     IP := IP + 1;

                  when 7 =>
                     -- SEMSIGNAL
                     Semaforos(IP - 64).Signal;
                     IP := IP + 1;

                  when others =>
                     Running := False;
                  end case;
               end loop;
            end Start;
         or
            accept Stop do
               Running := False; -- Detener la ejecución del bucle
            end Stop;
         end select;
      end loop;
   end CPU;

-- Array de CPUs
   CPU_1 : CPU;
   CPU_2 : CPU;
   Result : Integer;
   
begin

    -- Inicialización
    Memoria.Escribir(64, 0); -- load
    Memoria.Escribir(0, 8);  -- guarda el 8 en el acumulador

    Memoria.Escribir(65, 2); -- add
    Memoria.Escribir(1, 13); -- suma 13 al acumulador

    Memoria.Escribir(66, 2); -- add
    Memoria.Escribir(2, 27); -- suma 27 al acumulador

    Memoria.Escribir(67, 1); -- store
    Memoria.Escribir(3, 50); -- escribe lo que esta en el acumulador a la posicion 50

    Semaforos(0).Init(1);

    -- Arranque de CPUs
    CPU_1.Start(1);
    CPU_2.Start(2);

    -- Finalización y resultado
    CPU_1.Stop;
    CPU_2.Stop;
    
    Memoria.Leer(50, Result);
    Put_Line("Resultado: " & Integer'Image(Result));

end Main;
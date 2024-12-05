library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_16x8 is
    port (
        clock    : in std_logic;                    -- Señal de reloj
        address  : in std_logic_vector(7 downto 0); -- Dirección de 8 bits
        data_out : out std_logic_vector(7 downto 0) -- Salida de datos de 8 bits
    );
end entity rom_16x8;

-- Arquitectura de la entidad
architecture rom_16x8_sync_arch of rom_16x8 is

    -- Constantes que representan instrucciones
    constant LDA_IMM : std_logic_vector(7 downto 0) := x"86";
    constant LDA_DIR : std_logic_vector(7 downto 0) := x"87";
    constant LDB_IMM : std_logic_vector(7 downto 0) := x"88";
    constant LDB_DIR : std_logic_vector(7 downto 0) := x"89";
    constant STA_DIR : std_logic_vector(7 downto 0) := x"96";
    constant STB_DIR : std_logic_vector(7 downto 0) := x"97";
	 constant BRA     : std_logic_vector(7 downto 0) := x"20"; -- Saltar siempre.

   -- Declaración del tipo de datos para la ROM y definición de su contenido.
	type rom_type is array (0 to 127) of std_logic_vector(7 downto 0); -- ROM de 128 posiciones con palabras de 8 bits.
	--SIGNAL EN : std_logic; -- Señal para habilitar la lectura de la ROM.
	constant ROM : rom_type := ( 
		0 => LDA_IMM, -- Dirección 0: Cargar inmediato en A.
		1 => x"AA",   -- Dirección 1: Valor constante x"AA".
		2 => STA_DIR, -- Dirección 2: Guardar A en dirección.
		3 => x"E0",   -- Dirección 3: Valor constante x"E0".
		4 => STB_DIR, -- Dirección 2: Guardar B en dirección.
		5 => x"CE",   -- Dirección 5: Valor constante x"00".
		others => x"00" -- Las demás direcciones contienen x"00".
	);

    -- Señal para habilitar el acceso
    signal EN : std_logic;

begin

    -- Proceso para habilitar el acceso a la memoria
    enable : process(address)
    begin
        -- Verifica si la dirección está dentro del rango permitido
        if ((to_integer(unsigned(address)) >= 0) and
            (to_integer(unsigned(address)) <= 127)) then
            EN <= '1'; -- Habilitación de acceso
        else
            EN <= '0'; -- Acceso deshabilitado
        end if;
    end process;

    -- Proceso para manejar la lectura sincronizada con el reloj
    memory : process(clock)
    begin
        if rising_edge(clock) then -- Detecta flanco de subida del reloj
            if EN = '1' then
                -- Convierte la dirección a entero y accede a la ROM
                data_out <= ROM(to_integer(unsigned(address)));
            else
                -- Si no está habilitado, salida por defecto
                data_out <= (others => '0');
            end if;
        end if;
    end process;

end architecture rom_16x8_sync_arch;


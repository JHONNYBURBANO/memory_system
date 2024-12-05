library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidad rw_96x8_sync
entity rw_96x8_sync is
    port (
        clock    : in std_logic;                    -- Señal de reloj
        address  : in std_logic_vector(7 downto 0); -- Dirección de 8 bits
        data_in  : in std_logic_vector(7 downto 0); -- Entrada de datos
        writer    : in std_logic;                    -- Señal de escritura
        data_out : out std_logic_vector(7 downto 0) -- Salida de datos
    );
end entity rw_96x8_sync;

-- Arquitectura
architecture behavorial of rw_96x8_sync is

    -- Tipo de datos para la memoria RW
    type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);

    -- Señal para la memoria
    signal RW : rw_type := (others => (others => '0')); -- Inicialización a ceros

    -- Señal de habilitación
    signal EN : std_logic;

begin

    -- Proceso para habilitar acceso a la memoria
    enable : process(address)
    begin
        -- Verifica si la dirección está dentro del rango 128-223
        if ((to_integer(unsigned(address)) >= 128) and
            (to_integer(unsigned(address)) <= 223)) then
            EN <= '1'; -- Habilitar acceso
        else
            EN <= '0'; -- Deshabilitar acceso
        end if;
    end process;

    -- Proceso principal para manejar lectura y escritura
    memory : process(clock)
    begin
        if rising_edge(clock) then -- Detecta flanco de subida del reloj
            if (EN = '1') then
                if (writer = '1') then
                    -- Escritura en la memoria
                    RW(to_integer(unsigned(address))) <= data_in;
                else
                    -- Lectura de la memoria
                    data_out <= RW(to_integer(unsigned(address)));
                end if;
            else
                -- Salida por defecto cuando no está habilitado
                data_out <= (others => '0');
            end if;
        end if;
    end process;

end architecture behavorial;

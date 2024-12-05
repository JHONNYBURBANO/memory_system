library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidad output_ports
entity output_ports is
    port (
        clock       : in std_logic;                       -- Señal de reloj
        reset       : in std_logic;                       -- Señal de reinicio (activo en '0')
        address     : in std_logic_vector(7 downto 0);    -- Dirección de 8 bits
        data_in     : in std_logic_vector(7 downto 0);    -- Entrada de datos
        writer       : in std_logic;                       -- Señal de escritura
        port_out_00 : out std_logic_vector(7 downto 0);   -- Salida del puerto 00
        port_out_01 : out std_logic_vector(7 downto 0);   -- Salida del puerto 01
        port_out_02 : out std_logic_vector(7 downto 0);   -- Salida del puerto 02
        port_out_03 : out std_logic_vector(7 downto 0);   -- Salida del puerto 03
        port_out_04 : out std_logic_vector(7 downto 0);   -- Salida del puerto 04
        port_out_05 : out std_logic_vector(7 downto 0)
    );
end entity output_ports;

-- Arquitectura del componente
architecture behavioral of output_ports is
begin

    -- Proceso para el puerto `port_out_00` (Dirección x"E0")
    U3 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_00 <= x"00"; -- Inicialización en reset
        elsif rising_edge(clock) then
            if (address = x"86" and writer = '1') then
                port_out_00 <= data_in; -- Actualización con entrada de datos
            end if;
        end if;
    end process;

    -- Proceso para el puerto `port_out_01` (Dirección x"E1")
    U4 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_01 <= x"00"; -- Inicialización en reset
        elsif rising_edge(clock) then
            if (address = x"87" and writer = '1') then
                port_out_01 <= data_in; -- Actualización con entrada de datos
            end if;
        end if;
    end process;

    -- Proceso para el puerto `port_out_02` (Dirección x"E2")
    U5 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_02 <= x"00"; -- Inicialización en reset
        elsif rising_edge(clock) then
            if (address = x"88" and writer = '1') then
                port_out_02 <= data_in; -- Actualización con entrada de datos
            end if;
        end if;
    end process;

    -- Proceso para el puerto `port_out_03` (Dirección x"E3")
    U6 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_03 <= x"00"; -- Inicialización en reset
        elsif rising_edge(clock) then
            if (address = x"89" and writer = '1') then
                port_out_03 <= data_in; -- Actualización con entrada de datos
            end if;
        end if;
    end process;

    -- Proceso para el puerto `port_out_04` (Dirección x"E4")
    U7 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_04 <= x"00"; -- Inicialización en reset
        elsif rising_edge(clock) then
            if (address = x"96" and writer = '1') then
                port_out_04 <= data_in; -- Actualización con entrada de datos
            end if;
        end if;
    end process;

    -- Proceso para el puerto `port_out_05` (Dirección x"E5")
    U8 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_05 <= x"00"; -- Inicialización en reset
        elsif rising_edge(clock) then
            if (address = x"97" and writer = '1') then
                port_out_05 <= data_in; -- Actualización con entrada de datos
            end if;
        end if;
    end process;

end architecture behavioral;

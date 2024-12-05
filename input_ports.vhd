library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidad input_ports con 6 puertos
entity input_ports is
    port (
        address       : in std_logic_vector(7 downto 0);  -- Dirección de 8 bits
        rom_data_out  : in std_logic_vector(7 downto 0);  -- Salida de la ROM
        rw_data_out   : in std_logic_vector(7 downto 0);  -- Salida del bloque RW
        port_in_00    : in std_logic_vector(7 downto 0);  -- Entrada de datos puerto 00
        port_in_01    : in std_logic_vector(7 downto 0);  -- Entrada de datos puerto 01
        port_in_02    : in std_logic_vector(7 downto 0);  -- Entrada de datos puerto 02
        port_in_03    : in std_logic_vector(7 downto 0);  -- Entrada de datos puerto 03
        port_in_04    : in std_logic_vector(7 downto 0);  -- Entrada de datos puerto 04
        port_in_05    : in std_logic_vector(7 downto 0);  -- Entrada de datos puerto 05
        data_out      : out std_logic_vector(7 downto 0)  -- Salida seleccionada
    );
end entity input_ports;

-- Arquitectura del componente
architecture behavioral of input_ports is
begin

    -- Proceso MUX para seleccionar la salida según la dirección
    MUX1 : process (
        address, rom_data_out, rw_data_out,
        port_in_00, port_in_01, port_in_02, port_in_03,
        port_in_04, port_in_05
    )
    begin
        if (to_integer(unsigned(address)) >= 0 and to_integer(unsigned(address)) <= 127) then
            data_out <= rom_data_out;  -- Dirección de 0x00 a 0x7F para la ROM
				
        elsif (to_integer(unsigned(address)) >= 128 and to_integer(unsigned(address)) <= 223) then
            data_out <= rw_data_out;   -- Dirección de 0x80 a 0xDF para RW
				
        elsif (address = x"F0") then
            data_out <= port_in_00;    -- Dirección específica para puerto 00
        elsif (address = x"F1") then
            data_out <= port_in_01;    -- Dirección específica para puerto 01
        elsif (address = x"F2") then
            data_out <= port_in_02;    -- Dirección específica para puerto 02
        elsif (address = x"F3") then
            data_out <= port_in_03;    -- Dirección específica para puerto 03
        elsif (address = x"F4") then
            data_out <= port_in_04;    -- Dirección específica para puerto 04
        elsif (address = x"F5") then
            data_out <= port_in_05;    -- Dirección específica para puerto 05
        else
            data_out <= x"00";         -- Valor por defecto si no coincide ninguna dirección
        end if;
    end process;

end architecture behavioral;

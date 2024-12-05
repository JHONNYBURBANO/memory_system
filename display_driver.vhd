library ieee;
use ieee.std_logic_1164.all;

-- Entidad del controlador del display
entity display_driver is
    port (
        nibble  : in std_logic_vector(3 downto 0);  -- Entrada de 4 bits (un nibble)
        seg_out : out std_logic_vector(6 downto 0) -- Salida para 7 segmentos
    );
end entity display_driver;

-- Arquitectura del controlador
architecture behavioral of display_driver is
begin
    -- Proceso para decodificar el nibble en la salida del display
    process(nibble)
    begin
        case nibble is
           when "0000" => seg_out <= "1000000"; -- 0
            when "0001" => seg_out <= "1111001"; -- 1
            when "0010" => seg_out <= "0100100"; -- 2
            when "0011" => seg_out <= "0110000"; -- 3
            when "0100" => seg_out <= "0011001"; -- 4
            when "0101" => seg_out <= "0010010"; -- 5
            when "0110" => seg_out <= "0000010"; -- 6
            when "0111" => seg_out <= "1111000"; -- 7
            when "1000" => seg_out <= "0000000"; -- 8
            when "1001" => seg_out <= "0010000"; -- 9
            when "1010" => seg_out <= "0001000"; -- A
            when "1011" => seg_out <= "0000000"; -- B
            when "1100" => seg_out <= "1000110"; -- C
            when "1101" => seg_out <= "1000000"; -- D
            when "1110" => seg_out <= "0000110"; -- E
            when "1111" => seg_out <= "0001110"; -- F
            when others => seg_out <= "1111111"; -- Apagado (estado por defecto)
        end case;
    end process;
end architecture behavioral;


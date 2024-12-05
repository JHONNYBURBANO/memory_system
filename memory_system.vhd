library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library memory;


-- Top-level entity
entity memory_system is
    port (
        clock       : in std_logic;
        reset       : in std_logic;
        address     : in std_logic_vector(7 downto 0);
        data_in     : in std_logic_vector(7 downto 0);
        writer      : in std_logic;
        data_out    : BUFFER std_logic_vector(7 downto 0);
		  display_segment_1  : out std_logic_vector(6 downto 0);
		  display_segment_2  : out std_logic_vector(6 downto 0);
		  display_segment_3  : out std_logic_vector(6 downto 0);
		  display_segment_4  : out std_logic_vector(6 downto 0)

    );
end entity memory_system;

architecture behavior of memory_system is

    -- Signal declarations

    signal rom_data_out  : std_logic_vector(7 downto 0);
    signal ram_data_out  : std_logic_vector(7 downto 0);
    signal port_out_data_00 : std_logic_vector(7 downto 0);
	 signal port_out_data_1 : std_logic_vector(7 downto 0);
	 signal port_out_data_2: std_logic_vector(7 downto 0);
	 signal port_out_data_3 : std_logic_vector(7 downto 0);
	 signal port_out_data_4 : std_logic_vector(7 downto 0);
	 signal port_out_data_5 : std_logic_vector(7 downto 0);
	 
	   -- Señales para dividir la dirección en nibbles alto y bajo
    signal address_high : std_logic_vector(3 downto 0); -- Nibble alto
    signal address_low  : std_logic_vector(3 downto 0); -- Nibble bajo
	 
	 signal data_in_high : std_logic_vector(3 downto 0); -- Nibble alto
	 -- Señales para dividir el dato en nibbles alto y bajo
    signal data_high : std_logic_vector(3 downto 0); -- Nibble alto de `data_out`
    signal data_low  : std_logic_vector(3 downto 0); -- Nibble bajo de `data_out`

begin

 
	 
 u0: entity memory.rom_16x8
        port map (
            clock    => clock,    
            address  => address, 
            data_out => rom_data_out
        );
 
 u1: entity memory.rw_96x8_sync
        port map (
            clock    => clock,    
            address  => address, 
            data_out => ram_data_out,
				writer   => writer,
				data_in  => data_in 
        );
 u2: entity memory.output_ports
        port map (
            clock    => clock,    
            address  => address, 
				writer   => writer,
				data_in  => data_in, 
				reset    => reset,
				port_out_00=> port_out_data_00, 
				port_out_01=> port_out_data_1,
				port_out_02=> port_out_data_2 ,
				port_out_03=> port_out_data_3 ,
				port_out_04=> port_out_data_4 ,
				port_out_05=> port_out_data_5 
        ); 
		  
  u3: entity memory.input_ports
        port map (
            address => address,      
            rom_data_out => rom_data_out,  -- Salida de la ROM
            rw_data_out  => ram_data_out,   -- Salida del bloque RW
            port_in_00   => port_out_data_00,   -- Entrada de datos puerto 00
            port_in_01   => port_out_data_1 ,  -- Entrada de datos puerto 01
            port_in_02   => port_out_data_2 ,  -- Entrada de datos puerto 02
            port_in_03   => port_out_data_3 ,  -- Entrada de datos puerto 03
            port_in_04   => port_out_data_4 ,  -- Entrada de datos puerto 04
            port_in_05   => port_out_data_5 ,  -- Entrada de datos puerto 05
            data_out     => data_out  -- Salida seleccionada
        );
	
	-- División de la dirección en nibble alto y bajo
    address_high <= address(7 downto 4); -- Bits 7 a 4
    address_low  <= address(3 downto 0); -- Bits 3 a 0
	 
	 -- División del dato en nibble alto y bajo
    data_high <= data_out(7 downto 4); -- Bits 7 a 4
    data_low  <= data_out(3 downto 0); -- Bits 3 a 0
	
	 -- Display Driver para el nibble alto
    u4_Ahigh: entity memory.display_driver
        port map (
            --nibble  => address_high,  -- Nibble alto de la dirección
				nibble  => address_high  ,  -- Nibble alto de la dirección
            seg_out => display_segment_1  -- Conexión al primer display
        );

    -- Display Driver para el nibble bajo
    u5_Alow: entity memory.display_driver
        port map (
            nibble  => address_low,   -- Nibble bajo de la dirección
            seg_out => display_segment_4  -- Conexión al segundo display
        );
		  
	  -- Display Driver para el nibble alto
    u6_Dhigh: entity memory.display_driver
        port map (
            nibble  => data_high,  -- Nibble alto de `data_out`
            seg_out => display_segment_3  -- Conexión al primer display
        );

    -- Display Driver para el nibble bajo
    u7_Dlow: entity memory.display_driver
        port map (
            nibble  => data_low,   -- Nibble bajo de `data_out`
            seg_out => display_segment_2  -- Conexión al segundo display
        );


end architecture behavior;

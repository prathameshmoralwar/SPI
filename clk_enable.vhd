--------------------------------------------------------------------------------------
------ Company: Chalmers University Of Technology  
------ Engineer: Prathamesh Prabhakar Moralwar
------ 
------ Create Date: 10/04/2017 07:26:17 PM
------ Design Name: Clock Enable
------ Module Name: counter - Behavioral
------ Project Name: A sampled system
------ Target Devices: Nexys4 DDR (xc7a100tcsg324-1)
------ Tool Versions: Vivado 2017.2
------ Description: Clock Enable module.
------ 
------ Dependencies: None
------ 
------ Revision:
------ Revision 0.01 - File Created
------ Additional Comments:
------ 
--------------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;

entity clk_enable is
  port( clk         : in std_logic;
        reset       : in std_logic;
        sample_clk  : out std_logic);
end entity;

architecture arch of clk_enable is

  signal sample_count : integer range 0 to 2500 := 0;

  begin
    process(clk)
      begin
        if rising_edge(clk) then
          if reset = '1' then
            sample_count <= 0;
            sample_clk <= '0';
            
          elsif sample_count < 2500 then
            sample_count <= sample_count + 1;
            sample_clk <= '0';
            
          elsif sample_count = 2500 then
            sample_count <= 0;
            sample_clk <= '1';
            
          end if;
        end if;
      end process;
end arch;



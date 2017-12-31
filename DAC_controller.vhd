--------------------------------------------------------------------------------------
------ Company: Chalmers University Of Technology  
------ Engineer: Prathamesh Prabhakar Moralwar
------ 
------ Create Date: 10/04/2017 07:26:17 PM
------ Design Name: 
------ Module Name: DAC controller
------ Project Name: A sampled system
------ Target Devices: Nexys4 DDR (xc7a100tcsg324-1)
------ Tool Versions: Vivado 2017.2
------ Description: DAC Controller.
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

entity DAC_controller is 
  port( clk             : in  std_logic;
        start           : in  std_logic;   -- changed to sample_clk in implementation
        data            : in  std_logic_vector(11 downto 0);
        reset           : in  std_logic;
        
        finished        : out std_logic;
        CS             : out std_logic;
        SDI             : out std_logic;
        SCK             : out std_logic; -- serial clock?
        LDAC            : out std_logic);
        
end entity;

architecture arch of DAC_controller is

  signal reg_data             : std_logic_vector(11 downto 0);
  signal count                : integer range 0 to 34 := 0;
  signal started              : std_logic;
  signal config_bits          : std_logic_vector(3 downto 0) := "0001";
  signal serial_clock_enable  : std_logic;
  signal count_ce             : integer range 0 to 30 := 0;

  

  begin
    
    process(clk)                    -- Create serial clock that controls SCL in the process below. 
      begin
        if rising_edge(clk) then
          if reset = '1' then
            count_ce <= 0;
            serial_clock_enable <= '0';
            
          elsif start = '1' then
            count_ce <= 0;
            serial_clock_enable <= '0';
            
          elsif start = '0' and started = '1' then
        
            if count_ce < 30 then
              count_ce <= count_ce + 1;
              serial_clock_enable <= '0';
          
            elsif count_ce = 30 then
              serial_clock_enable <= '1';
              count_ce <= 0;
            end if;
          end if;
        end if;
      end process;
      
    
    process(clk)                -- Process to handle the output
      begin
        if rising_edge(clk) then
          if reset = '1' then
            finished <= '0';
            CS  <= '1';
            SDI <= '0';
            SCK <= '0';
            started <= '0';
            reg_data <= (others => '0');
          
            
          elsif start = '1' then
              reg_data <= data;
              count <= 0;
              CS  <= '1';
              SDI <= '0';
              SCK <= '0';
              started <= '1';
              
          elsif started = '1' and start = '0' then
            
            if serial_clock_enable = '1' then
                case count is
                when 0 => CS  <= '1';
                          SCK <= '0';
                          SDI <= '0';
                          count <= count + 1;
                when 1 => CS  <= '0';
                          SCK <= '0';
                          SDI <= config_bits(3);
                          count <= count + 1;
                when 2 => CS  <= '0';
                          SCK <= '1';
                          SDI <= config_bits(3);
                          count <= count + 1;
                when 3 => CS  <= '0';
                          SCK <= '0';
                          SDI <= config_bits(2);
                          count <= count + 1;
                when 4 => CS  <= '0';
                          SCK <= '1';
                          SDI <= config_bits(2);
                          count <= count + 1;
                when 5 => CS  <= '0';
                          SCK <= '0';
                          SDI <= config_bits(1);
                          count <= count + 1;
                when 6 => CS  <= '0';
                          SCK <= '1';
                          SDI <= config_bits(1);
                          count <= count + 1;
                when 7 => CS  <= '0';
                          SCK <= '0';
                          SDI <= config_bits(0);
                          count <= count + 1;
                when 8 => CS  <= '0';
                          SCK <= '1';
                          SDI <= config_bits(0);
                          count <= count + 1;
                when 9 => CS  <= '0';
                          SCK <= '0';
                          SDI <= reg_data(11);
                          count <= count + 1;
                when 10 => CS  <= '0';
                          SCK <= '1';
                          SDI <= reg_data(11);
                          count <= count + 1;
                when 11 => CS  <= '0';
                          SCK <= '0';
                          SDI <= reg_data(10);
                          count <= count + 1;
                when 12 => CS  <= '0';
                          SCK <= '1';
                          SDI <= reg_data(10);
                          count <= count + 1;
                when 13 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(9);
                          count <= count + 1;
                when 14 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(9);
                          count <= count + 1;
                when 15 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(8);
                          count <= count + 1;
                when 16 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(8);
                          count <= count + 1;
                when 17 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(7);
                          count <= count + 1;
                when 18 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(7);
                          count <= count + 1;
                when 19 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(6);
                          count <= count + 1;
                when 20 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(6);
                          count <= count + 1;
                when 21 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(5);
                          count <= count + 1;
                when 22 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(5);
                          count <= count + 1;
                when 23 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(4);
                          count <= count + 1;
                when 24 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(4);
                          count <= count + 1;
                when 25 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(3);
                          count <= count + 1;
                when 26 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(3);
                          count <= count + 1;
                when 27 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(2);
                          count <= count + 1;
                when 28 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(2);
                          count <= count + 1;
                when 29 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(1);
                          count <= count + 1;
                when 30 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(1);
                          count <= count + 1;
                when 31 => CS <= '0';
                          SCK <= '0';
                          SDI <= reg_data(0);
                          count <= count + 1;
                when 32 => CS <= '0';
                          SCK <= '1';
                          SDI <= reg_data(0);
                          count <= count + 1;
                when 33 => CS <= '0';
                          SCK <= '0';
                          SDI <= '0';
                          count <= count + 1;
                when 34 => CS <= '1';
                          finished <= '1';
                          started <= '0';                          
                when others => count <= 0;
                end case;
            
              end if;
          end if;
        end if;
      end process;
    
    LDAC <= '0';
        
end arch;

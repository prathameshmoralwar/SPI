--------------------------------------------------------------------------------------
------ Company: Chalmers University Of Technology  
------ Engineer: Prathamesh Prabhakar Moralwar
------ 
------ Create Date: 10/04/2017 07:26:17 PM
------ Design Name: 
------ Module Name: ADC controller
------ Project Name: A sampled system
------ Target Devices: Nexys4 DDR (xc7a100tcsg324-1)
------ Tool Versions: Vivado 2017.2
------ Description: ADC Controller.
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

entity ADC_controller is
  port( clk         : in std_logic;
        start       : in std_logic;
        reset       : in std_logic;
        D_out       : in std_logic;
        
        finished    : out std_logic;
        CSn         : out std_logic;
        SCL         : out std_logic;
        D_in        : out std_logic;
        data        : out std_logic_vector(11 downto 0));  
end entity;

architecture arch of ADC_controller is

  signal count_ce             : integer range 0 to 30 := 0;
  signal count                : integer range 0 to 36 := 0;
  signal reg_data             : std_logic_vector(11 downto 0);
  signal serial_clock_enable  : std_logic;
  signal conf_bits            : std_logic_vector(3 downto 0) := "1101"; -- Status
  signal started              : std_logic;

  begin
    
    process(clk)                      -- SPI Clock
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
      
      process(clk)                  -- Process that sends controlbits D_out to AD, collect input D_in from AD, converts it to array data and sends to DAC_converter
        begin
        if rising_edge(clk) then
          if reset = '1' then
            finished <= '0';
            CSn <= '1';
            SCL <= '0';
            D_in <= '0';
            started <= '0';
            count <= 0;
            reg_data <= (others => '0');
            
          elsif start = '1' then
            count <= 0;
            CSn <= '1';
            SCL <= '0';
            D_in <= '0';
            started <= '1';
            
          elsif started = '1' and start = '0' then
            
            if serial_clock_enable = '1' then
              case count is 
              when 0 => CSn <= '1';
                        SCL <= '0';
                        count <= count + 1;
              when 1 => CSn <= '0';
                        SCL <= '0';
                        D_in <= conf_bits(3);
                        count <= count + 1;
              when 2 => CSn <= '0';
                        SCL <= '1';
                        D_in <= conf_bits(3);
                        count <= count + 1;
              when 3 => CSn <= '0';
                        SCL <= '0';
                        D_in <= conf_bits(2);
                        count <= count + 1;
              when 4 => CSn <= '0';
                        SCL <= '1';
                        D_in <= conf_bits(2);
                        count <= count + 1;
              when 5 => CSn <= '0';
                        SCL <= '0';
                        D_in <= conf_bits(1);
                        count <= count + 1;
              when 6 => CSn <= '0';
                        SCL <= '1';
                        D_in <= conf_bits(1);
                        count <= count + 1;
              when 7 => CSn <= '0';
                        SCL <= '0';
                        D_in <= conf_bits(0);
                        count <= count + 1;
              when 8 => CSn <= '0';            
                        SCL <= '1';
                        D_in <= conf_bits(0);
                        count <= count + 1;                     
                        
              when 9 => CSn <= '0';
                        SCL <= '0';             -- Null bit needed as per ADC datasheets
                        count <= count + 1;
              when 10 => CSn <= '0';
                        SCL <= '1';
                        count <= count + 1;     -- Null bit as per ADC datasheets
              when 11 => CSn <= '0';
                        SCL <= '0';
                        reg_data(11) <= D_out;
                        count <= count + 1;
              when 12 => CSn <= '0';
                        SCL <= '1';
                        reg_data(11) <= D_out;
                        count <= count + 1;
              when 13 => CSn <= '0';
                        SCL <= '0';
                        reg_data(10) <= D_out;
                        count <= count + 1;
              when 14 => CSn <= '0';
                        SCL <= '1';
                        reg_data(10) <= D_out;
                        count <= count + 1;
              when 15 => CSn <= '0';
                        SCL <= '0';
                        reg_data(9) <= D_out;
                        count <= count + 1;
              when 16 => CSn <= '0';
                        SCL <= '1';
                        reg_data(9) <= D_out;
                        count <= count + 1; 
              when 17 => CSn <= '0';
                        SCL <= '0';
                        reg_data(8) <= D_out;
                        count <= count + 1;
              when 18 => CSn <= '0';
                        SCL <= '1';
                        reg_data(8) <= D_out;
                        count <= count + 1;
              when 19 => CSn <= '0';
                        SCL <= '0';
                        reg_data(7) <= D_out;
                        count <= count + 1;
              when 20 => CSn <= '0';
                        SCL <= '1';
                        reg_data(7) <= D_out;
                        count <= count + 1;
              when 21 => CSn <= '0';
                        SCL <= '0';
                        reg_data(6) <= D_out;
                        count <= count + 1;
              when 22 => CSn <= '0';
                        SCL <= '1';
                        reg_data(6) <= D_out;
                        count <= count + 1;              
              when 23 => CSn <= '0';
                        SCL <= '0';
                        reg_data(5) <= D_out;
                        count <= count + 1;
              when 24 => CSn <= '0';
                        SCL <= '1';
                        reg_data(5) <= D_out;
                        count <= count + 1;
              when 25 => CSn <= '0';
                        SCL <= '0';
                        reg_data(4) <= D_out;
                        count <= count + 1;
              when 26 => CSn <= '0';
                        SCL <= '1';
                        reg_data(4) <= D_out;
                        count <= count + 1;
              when 27 => CSn <= '0';
                        SCL <= '0';
                        reg_data(3) <= D_out;
                        count <= count + 1;
              when 28 => CSn <= '0';
                        SCL <= '1';
                        reg_data(3) <= D_out;
                        count <= count + 1; 
              when 29 => CSn <= '0';
                        SCL <= '0';
                        reg_data(2) <= D_out;
                        count <= count + 1;
              when 30 => CSn <= '0';
                        SCL <= '1';
                        reg_data(2) <= D_out;
                        count <= count + 1;
              when 31 => CSn <= '0';
                        SCL <= '0';
                        reg_data(1) <= D_out;
                        count <= count + 1;
              when 32 => CSn <= '0';
                        SCL <= '1';
                        reg_data(1) <= D_out;
                        count <= count + 1;
              when 33 => CSn <= '0';
                        SCL <= '0';
                        reg_data(0) <= D_out;
                        count <= count + 1;
              when 34 => CSn <= '0';
                        SCL <= '1';
                        reg_data(0) <= D_out;
                        count <= count + 1;
              when 35 => CSn <= '0';
                        SCL <= '0';
                        count <= count + 1;
              when 36 => CSn <= '1';
                        finished <= '1';
                        started <= '0';
                        data <= reg_data;       -- Send data when finished is set
              when others => count <= 0;
              end case;
              
            end if;
          end if;
        end if;
      end process;
      
      
      
end arch;

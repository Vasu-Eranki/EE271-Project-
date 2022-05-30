#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display
int state_0 = 7; 
int state_1 = 6;
int state_2 = 5; 
int state_3 = 4;  
int delay_unit = 5000;
void setup()
{
   Wire.setClock(400000L);
  lcd.init();                      // initialize the lcd 
  lcd.backlight();
  pinMode(state_0, INPUT);
  pinMode(state_1,INPUT);
  pinMode(state_2,INPUT);
  pinMode(state_3,INPUT);
  lcd.setCursor(4,0);
  lcd.print("Group 9");
}
void loop(){
    while(digitalRead(state_0)!=HIGH);
    lcd.clear();
    lcd.setCursor(4,0);
    lcd.print("Group 9");
    lcd.setCursor(4,1);
    lcd.print("Reset");
    while(digitalRead(state_1)!=HIGH);
    lcd.setCursor(2,1);
    lcd.print("SRAM A Input"); 
    while(digitalRead(state_2)!=HIGH);
    lcd.setCursor(2,1);
    lcd.print("SRAM B Input");
    while(digitalRead(state_3)!=HIGH);
    lcd.clear();
    lcd.setCursor(4,0);
    lcd.print("Group 9");
    lcd.setCursor(2,1);
    lcd.print("FP MAC CALC");
}

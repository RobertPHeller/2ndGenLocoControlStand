#include <Arduino.h>
#include <stdio.h>
#include <ControlStandReport.h>

#include <Wire.h>
#include <Adafruit_MCP23008.h>

ControlStandReport cs = ControlStandReport();
Adafruit_MCP23008 mcp;

void setup () {
  analogReference(DEFAULT);                                                   
  Serial.begin(115200);                                                       
  Serial.println("Control Stand 0.0");                                        
  Serial.print(">>");                                                         
  Serial.flush();
  mcp.begin();
  cs.SetMcp(&mcp);
  //mcp.pinMode(...);
  //mcp.pullUp(...);
}

void loop() {
  //mcp.digitalRead(...);
  //mcp.digitalWrite(...);
  cs.ReadControls();
  cs.ProcessSerialCLI();
}



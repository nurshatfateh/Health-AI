#include <WiFi.h>
#include <MAX30100_PulseOximeter.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <FirebaseESP32.h>
#include "time.h"

#define WIFI_SSID "HealthAI"
#define WIFI_PASSWORD "12345678"

#define DS18B20_PIN 17
float tempF, tempC, temperature;
int heartRate, oxygenLevel, flag = 0;
#define LED_PIN 2
#define REPORTING_PERIOD_MS 1000

#define FIREBASE_HOST "https://healthai2-a6e15-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "AIzaSyBEeWsWHBxeteVyEfWwTbzrzcMvhudqEJE"

FirebaseData firebaseData;
FirebaseJson json;

PulseOximeter pox;
String TIME;

const char* ntpServer = "pool.ntp.org";
const long gmtOffset_sec = 3600 * 6;
const int daylightOffset_sec = 0;


uint32_t tsLastReport = 0;
OneWire oneWire(DS18B20_PIN);
DallasTemperature ds18b20(&oneWire);

void onBeatDetected() {
  Serial.println("Beat Detected!");
  digitalWrite(LED_PIN, HIGH);  // Turn on the LED
  delay(1);                     //
  digitalWrite(LED_PIN, LOW);   // Turn off the LED
}


void printLocalTime() {
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    Serial.println("Failed to obtain time");
    return;
  }

  Serial.println(&timeinfo, "%A, %B %d %Y %H:%M:%S");
  int day = timeinfo.tm_mday;
  int month = timeinfo.tm_mon + 1;
  int year = timeinfo.tm_year;
  int hour = timeinfo.tm_hour;
  int min = timeinfo.tm_min;
  int sec = timeinfo.tm_sec;

  String DAY, MONTH, HOUR, MIN, SEC;

  if (day < 10) {
    DAY = "0" + String(day);
  } else {
    DAY = String(day);
  }

  if (month < 10) {
    MONTH = "0" + String(month);
  } else {
    MONTH = String(month);
  }

  if (hour < 10) {
    HOUR = "0" + String(hour);
  } else {
    HOUR = String(hour);
  }

  if (min < 10) {
    MIN = "0" + String(min);
  } else {
    MIN = String(min);
  }

  if (sec < 10) {
    SEC = "0" + String(sec);
  } else {
    SEC = String(sec);
  }


  TIME = String(year + 1900) + "-" + MONTH + "-" + DAY + "T" + HOUR + ":" + MIN + ":" + SEC + "Z";
}



void updatePulseOximeter(void* parameter) {

  while (true) {
    delay(10);
    pox.update();
    if (millis() - tsLastReport > REPORTING_PERIOD_MS) {
      heartRate = pox.getHeartRate();
      oxygenLevel = pox.getSpO2();
      Serial.printf("Heart rate: %d bpm, Oxygen level: %d percent \n", heartRate, oxygenLevel);
      tsLastReport = millis();
    }

    if (flag==1) {
     // Serial.println("Press reset button to measure again");
     pox.shutdown();
      while (1) {}
    }
  }
}



float round2(float value) {
   return (int)(value * 100 + 0.5) / 100.0;
}


void setup() {
  Serial.begin(115200);

  // Initialize the pulse oximeter
  if (!pox.begin()) {
    Serial.println("FAILED");
    for (;;)
      ;
  } else {
    Serial.println("SUCCESS");
  }

  // Initialize the temperature sensor
  ds18b20.begin();
  pinMode(LED_PIN, OUTPUT);

  Serial.begin(115200);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");
  digitalWrite(LED_PIN, HIGH);  // Turn on the LED
  delay(1000);                     //
  digitalWrite(LED_PIN, LOW);

  // Initialize the pulse oximeter
  if (!pox.begin()) {
    Serial.println("POX FAILED");
    for (;;)
      ;
  } else {
    Serial.println("POX SUCCESS");
  }

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);


  pox.setIRLedCurrent(MAX30100_LED_CURR_7_6MA);

  pox.setOnBeatDetectedCallback(onBeatDetected);

  // Initialize the temperature sensor
  ds18b20.begin();
  pinMode(LED_PIN, OUTPUT);

  xTaskCreatePinnedToCore(
    updatePulseOximeter,  // Task function
    "poxUpdateTask",      // Task name
    10000,                // Stack size (in bytes)
    NULL,                 // Task parameter
    1,                    // Task priority
    NULL,                 // Task handle
    1                     // Core to run the task on (core 1)
  );                      // Core number (1 for the second core)

  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
  printLocalTime();
  Serial.println(TIME);

  
}




void loop() {
  
 if (TIME != ""){
  json.set(TIME + "/heart_rate", 0);
  json.set(TIME + "/oxygen_level", 0);
  json.set(TIME + "/temperature", 75);
  json.set(TIME + "/time", TIME);
  json.set(TIME + "/elasped_time", 0);
  json.set(TIME + "/progress", 0);
  json.set(TIME + "/connected", 1.00);

  if (!Firebase.updateNode(firebaseData, "/SensorData", json))
   {
     Serial.println("Failed to initialized");
     while(1);
   }
}

  Serial.println("Please wait 45 second");
  for (int i = 0; i < 46; i++) {
    delay(500);
    Serial.printf("Elasped time : %d Sec \n", i);

    ds18b20.requestTemperatures();
    float temperature = ds18b20.getTempCByIndex(0) * 9 / 5 + 32 + 3.2;
    float temp=round2(temperature);
    Serial.printf("Temperature: %f C \n", temperature);
    json.set(TIME + "/temperature", temp);
    json.set(TIME + "/elasped_time", i);
    json.set(TIME + "/connected", 1);
    Firebase.updateNode(firebaseData, "/SensorData", json);


    delay(500);
  }

    ds18b20.requestTemperatures();
    float temperature = ds18b20.getTempCByIndex(0) * 9 / 5 + 32 + 3.5;
    float temp=round2(temperature);
    Serial.printf("Temperature: %f C \n", temperature);

  xx:
  if (TIME != "") {
    json.set(TIME + "/heart_rate", heartRate);
    json.set(TIME + "/oxygen_level", oxygenLevel);
    json.set(TIME + "/temperature", temp);
    json.set(TIME + "/time", TIME);
    json.set(TIME + "/progress", 1.00);
    json.set(TIME + "/connected", 0);
    if (Firebase.updateNode(firebaseData, "/SensorData", json)) {
      Serial.println("Data uploaded successfully");
       flag = 1;
      digitalWrite(LED_PIN, HIGH);
    } else {
      Serial.println("Data upload failed");
    }

    Serial.println("Press reset button to measure again");
    while (1) {
     
    }
  }
  else
   goto xx;

}

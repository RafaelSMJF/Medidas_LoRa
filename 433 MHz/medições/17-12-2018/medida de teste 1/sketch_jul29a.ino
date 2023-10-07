


/*
 ** MOSI - pin 11
 ** MISO - pin 12
 ** CLK - pin 13
 ** CS - pin 4
*/

#include <SPI.h>
#include <SD.h>
#include <LoRa.h>
#include <SoftwareSerial.h>
#include <TinyGPS.h>

SoftwareSerial serial1(5,6); // RX, TX
TinyGPS gps1;
 
//criar um objeto File para manipular um arquivo
File myFile;
const int ledLora = 8; // cria uma constante com o numero do pino ligado ao LED
const int ledSD = 7; // cria uma constante com o numero do pino ligado ao LED
const int inputPin = 2; // cria uma constante com o numero do pino conectado a tecla


void setup() {
  serial1.begin(9600);
  //while (!Serial);
  pinMode(ledLora, OUTPUT);
  pinMode(ledSD, OUTPUT);
  pinMode(inputPin, INPUT);
  digitalWrite(ledLora, LOW);
  digitalWrite(inputPin, LOW);
 if (!LoRa.begin(433E6)) {
   digitalWrite(ledLora, HIGH);
    while (1);
  }
  digitalWrite(ledLora, HIGH);
  delay(500);
  digitalWrite(ledLora, LOW);
  LoRa.setSpreadingFactor(10);
  LoRa.setSignalBandwidth(62.5E3);
  LoRa.crc(); 
 // Serial.print("Inicializa o SD card...");
 
  if (SD.begin(4)) {
   // Serial.println("Nao inicializado. Veja no texto adiante sobre isso.");
    //return;
    digitalWrite(ledSD, HIGH);
    delay(500);
    digitalWrite(ledSD, LOW);
  }
  //Serial.println("Beleza! Seguindo...");
 
  /* A biblioteca SD tem um metodo para abrir arquivos e esse arquivo aberto
  sera armazenado no objeto myFile, descrito ao inicio desse codigo. Somente 
  um arquivo pode ser aberto por vez, portanto nao se esqueca de fecha-lo
  antes de abrir um novo ou voce tera problemas.
  */
 
  myFile = SD.open("Dados.txt", FILE_WRITE);
 

 
}
 
void loop() {
  
static unsigned long delayPrint;
  bool recebido = false;
  long int cont =0;
  int packetSize = LoRa.parsePacket();
  int val = digitalRead(inputPin);
  int primeiro=0,passou=0;

  while(1)
  {
    
   val = digitalRead(inputPin);
   if( primeiro ==0)
   {
   if(val==0)
   {
         packetSize = LoRa.parsePacket();
         while (LoRa.available()) 
        {
           digitalWrite(ledLora, HIGH);
           myFile.print((char)LoRa.read());
           passou=1;
           digitalWrite(ledSD, HIGH);
        }
        if(passou==1)
        {
              passou=0;
              myFile.print(" RSSI ");
              myFile.print(LoRa.packetRssi());
              myFile.print(" SNR ");
              myFile.print(LoRa.packetSnr());
              myFile.print(" Frequency_Erro ");
              myFile.print(LoRa.packetFrequencyError());

       
////////////////////////////////////
            while (serial1.available()) 
              {
                  char cIn = serial1.read();
                  recebido = (gps1.encode(cIn) || recebido);  //Verifica até receber o primeiro sinal dos satelites
    
              }
             
              if ( (recebido) )///&& ((millis() - delayPrint) > 1000) ) 
              {  //Mostra apenas após receber o primeiro sinal. Após o primeiro sinal, mostra a cada segundo.
                // delayPrint = millis();
     
                //Serial.println("----------------------------------------");
     
         //Latitude e Longitude
               
               float latitude=0.000000;
               float longitude= 0.000000; //As variaveis podem ser float, para não precisar fazer nenhum cálculo
     
                unsigned long idadeInfo;
                gps1.f_get_position(&latitude, &longitude, &idadeInfo);   //O método f_get_position é mais indicado para retornar as coordenadas em variáveis float, para não precisar fazer nenhum cálculo    

                if (latitude != TinyGPS::GPS_INVALID_F_ANGLE) 
                {
                    myFile.print(" Latitude ");
                    myFile.print(latitude,06);
        
                    //Serial.print("Latitude: ");
                    //Serial.println(latitude, 6);  //Mostra a latitude com a precisão de 6 dígitos decimais
                }

               if (longitude != TinyGPS::GPS_INVALID_F_ANGLE) 
               {
                    myFile.print(" Longitude ");
                    myFile.print(longitude,06);
        
                    //Serial.print("Longitude: ");
                    //Serial.println(longitude, 6);  //Mostra a longitude com a precisão de 6 dígitos decimais
                }

    
     //altitude
               float altitudeGPS;
               altitudeGPS = gps1.f_altitude();

               if ((altitudeGPS != TinyGPS::GPS_INVALID_ALTITUDE) && (altitudeGPS != 1000000)) 
               {
  
                    myFile.print(" Altitude ");
                     myFile.print(altitudeGPS);
                     //      Serial.print("Altitude (cm): ");
                    //    Serial.println(altitudeGPS);
               }

//velocidade
              float velocidade;
             //velocidade = gps1.speed();        //nós
             velocidade = gps1.f_speed_kmph();   //km/h
            //velocidade = gps1.f_speed_mph();  //milha/h
            //velocidade = gps1.f_speed_mps();  //milha/segundo
           myFile.print(" Velocidade_(km/h)  ");
           myFile.print(velocidade,02);
           // Serial.print("Velocidade (km/h): ");
            //Serial.println(velocidade, 2);  //Conversão de Nós para Km/h



     //sentito (em centesima de graus)
     unsigned long sentido;
     sentido = gps1.course();
     myFile.print(" Sentido_(graus) ");
     myFile.print(float(sentido)/100,02);
     //Serial.print("Sentido (grau): ");
     //Serial.println(float(sentido) / 100, 2);


     //satelites e precisão
     unsigned short satelites;
     unsigned long precisao;
     satelites = gps1.satellites();
     precisao =  gps1.hdop();

     if (satelites != TinyGPS::GPS_INVALID_SATELLITES) {
        myFile.print(" Satelites  ");
        myFile.print(satelites);
        //Serial.print("Satelites: ");
        //Serial.println(satelites);
     }

     if (precisao != TinyGPS::GPS_INVALID_HDOP) {
       myFile.print(" Precisao_(centesimos_de_seg)  ");
           myFile.print(precisao);
       // Serial.print("Precisao (centesimos de segundo): ");
       // Serial.println(precisao);
     }




/*

     float distancia_entre;
     distancia_entre = gps1.distance_between(-21.7793117,-43.3735127,latitude,longitude);
      myFile.print(" distancia ");
           myFile.print(distancia_entre);
     float sentido_para;
     sentido_para = gps1.course_to(-21.7793117,-43.3735127,latitude,longitude);
      myFile.print(" sentido ");
      myFile.print(sentido_para);
*/
              }
  myFile.println(" ");


        ////////////////////////////////
        
      }
      digitalWrite(ledLora, LOW);
      digitalWrite(ledSD, LOW);
    
  
    }
    }
     if(primeiro ==1)
     {
    if(val==0)
    {
     digitalWrite(ledSD, HIGH);
    delay(500);
    digitalWrite(ledSD, LOW);
      primeiro=0;
      SD.open("Dados.txt");  
    }
     }
    if(val==1)
    {
      digitalWrite(ledSD, HIGH);
      primeiro =1;
      myFile.close();
     }
    
  }
}

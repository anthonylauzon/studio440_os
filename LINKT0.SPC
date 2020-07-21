partition {
          overlay {
                  region {} MAIN     [addr=0];
                  }
                  TRAPREG0;
          }
          TRAPREG0 [addr=0];



partition {
          overlay {
                  region {} LONGRAM [size=0x78000];
                  region {} SHORTRAM [addr=0x78000, size=0x7800];
                  }ram;
          }
          RAM [addr=0xFFF80000];


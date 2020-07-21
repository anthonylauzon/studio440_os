partition {
          overlay {
                  region {} VECTORS [size=0x100];
                  region {} MAIN    [addr=0x100, size=0x1FF00];
                  }rom;
          }ROM [addr=0];



partition {
          overlay {
                  region {} LONGRAM [size=0x78000];
                  region {} SHORTRAM [addr=0x78000, size=0x7800];
                  }ram;
          }RAM [addr=0xFFF80000];

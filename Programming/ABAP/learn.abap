REPORT zhello2002.

DATA music_album TYPE c LENGTH 14.
music_album = 'nowhere -- ride'.
WRITE: music_album.
SKIP.

DATA album_rating TYPE i VALUE 7.
DATA music_album_2 LIKE music_album.
WRITE: / 'album', music_album, ' is rated', album_rating.
SKIP.

DATA music_ptr TYPE REF TO i.
GET REFERENCE OF album_rating INTO music_ptr.
WRITE: / 'dereferenced pointer', music_ptr->*.

* selection-screen begin of line.
* selection-screen comment 1(0) '8charonly'.
PARAMETERS: echo   TYPE string, repeat TYPE i.
* selection-screen end of line.

DO repeat TIMES.
  WRITE / echo.
  SKIP.
ENDDO.

WHILE repeat <> 0.
  WRITE: 'album rating here is', album_rating.
  SKIP.
  repeat = repeat - 1.
ENDWHILE.

TYPES: BEGIN OF album_custom_type,
         name   TYPE string, rating TYPE p,
       END OF album_custom_type.

" NOT Working, need to figure this out
"DATA album_2 TYPE REF TO album_custom_type.
"album_2->name = 'blackwater park'.
"album_2->rating = '10.0'.
"WRITE album_2->name.

" ADD CLASS and FUNCTIONS as well

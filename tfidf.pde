import org.atilika.kuromoji.Token;
import org.atilika.kuromoji.Tokenizer;
import java.util.*;

Tokenizer tokenizer = Tokenizer.builder().build();
String[] all_words = {};
String[][] doc_word_list;
String[] stopWords = {"を","は","に","は","，","て",
                      "#","!","！","？","?","＃","～#",
                      "から","くれ","。","，","．",
                      "1","2","3","4","5",
                      "6","7","8","9","10","0",
                      "EP","です","の","笑","w","た","演習","発表","って","めっちゃ",
                      " ","　"," #","な","で","か","ｗ","ぼ","こと",
                      "　#","え","いい","ああ","し","ない","と",
                      "、","ー","てる","これ","ん","よ","www","ま","まし",
                      "だ","が","お","ね",".","…","！#","すごい","ゲーム",
                      "う","ぞ","すぎ","い","「","」","ｗｗｗｗ","すげ","やばい",
                      "おお","ep","も","ｗｗｗ","/","さ","ます","ある","うる","き","じゃ",
                      "くん","？#","  ","（","/","あ","や","）","(",")","〜","wwwwww",
                      "ww","そう","たい","れ","この","さん","ええ","せ","する","ちゃん"};



void setup(){
  Document epday1 = new Document( loadStrings("togetter_2016ep1.tsv") );
  Document epday2 = new Document( loadStrings("togetter_2016ep2.tsv") );
  Document epday3 = new Document( loadStrings("togetter_2016ep3.tsv") );

  all_words = join3Arrays(epday1.word_list, epday2.word_list, epday3.word_list);

  doc_word_list = new String[3][];
  doc_word_list[0] = epday1.word_list;
  doc_word_list[1] = epday2.word_list;
  doc_word_list[2] = epday3.word_list;


  epday1.calculate_tfidf();
  epday2.calculate_tfidf();
  epday3.calculate_tfidf();
}




String[] join3Arrays(String[] arr1, String[] arr2, String[] arr3){
  String[] tmp = concat( arr1, arr2);
  String[] result = concat( tmp, arr3);

  return result;
}

class Document {

  String[] file; // 読み込むTSVファイル
  String[] word_list;
  HashMap<String, Integer> word_vec;
  HashMap<String, Integer> top20word;
  // HashMap<String, Integer> tf;
  // HashMap<String, Integer> df;
  // HashMap<String, Integer> idf;
  // HashMap<String, Integer> tfidf;
  float total_appearance;    // 全単語の出現回数の和


  Document(String[] _file){
    file = _file;
    word_vec = createBow(file);
    word_list = getWordList(word_vec);
    calculate_total_appearance(word_vec);
    top20word = getTop20( sortMap(word_vec) );
  }


  void calculate_tfidf(){
  // HashMap<String, Integer> calculate_tfidf(){
    HashMap<String, Integer> result = new HashMap<String, Integer>();
    Iterator<String> iterator = top20word.keySet().iterator();

    println("出現頻度TOP20のTFIDF");
    println("");
    while (iterator.hasNext ()) {
      String key = iterator.next();
      float TF = top20word.get(key) / total_appearance;
      float DF = count(doc_word_list, key);
      float IDF = log( doc_word_list.length / (DF+1) );
      float TFIDF = TF * IDF;

      println(key +'\t'+ TFIDF);
    }
    println("");
    println("=============================");
  }


  // 単語ベクトルの生成（単語：出現回数）
  HashMap<String, Integer> createBow(String[] arr){
    HashMap<String, Integer> bow = new HashMap();

    for(int i=0; i<arr.length; i++){
      String[] parts = arr[i].split("\t");
      List<Token> list_token = tokenizer.tokenize( parts[2] );

      for ( Token token : list_token ) {
        String[] features = token.getAllFeaturesArray();

        if( !isStopWord( token.getSurfaceForm() ) ){
          if( bow.get( token.getSurfaceForm()) == null ){
            bow.put( token.getSurfaceForm(), 1 );
          }else{
            int count = bow.get( token.getSurfaceForm() );
            count++;
            bow.put( token.getSurfaceForm(), count );
          }
        }
      }
    }
    return bow;
  }


  // 全単語の出現回数の和を計算
  void calculate_total_appearance(HashMap<String, Integer> map){
    Iterator<String> iterator = map.keySet().iterator();

    while (iterator.hasNext ()) {
      String key = iterator.next();
      total_appearance += float(map.get(key));
    }
  }

  // 出現単語(重複なし) の生成
  String[] getWordList(HashMap<String, Integer> map){
    String[] result = {};
    Iterator<String> iterator = map.keySet().iterator();

    while (iterator.hasNext ()) {
      String key = iterator.next();
      result = append(result, key);
    }
    return result;
  }


  // ある配列がある要素を持つかどうか判定（１次元配列Ver）
  boolean has(String[] arr, String value){
    boolean judge = false;
    for(String a : arr){
     if(a.equals(value)){
       judge = true;
     }
    }
    return judge;
  }


  // ある要素がある２次元配列にいくつ含まれているか
  int count(String[][] arr, String value){
    int count = 0;

    for(String[] ar : arr){
      for(String a : ar){
        if(a.equals(value)){
          count++;
          break;
        }
      }
    }
    return count;
  }


  // StopWordか判定
  boolean isStopWord(String str){
   if(has(stopWords, str)){
     return true;
   }else{
     return false;
   }
  }

  // HashMapを出現回数順にソート
  ArrayList sortMap(HashMap<String,Integer> map){
    ArrayList entries = new ArrayList(map.entrySet() );

    Collections.sort(entries,
      new Comparator() {
        public int compare(Object obj1, Object obj2) {
          Map.Entry ent1 =(Map.Entry)obj1;
          Map.Entry ent2 =(Map.Entry)obj2;
          return (int)ent2.getValue() - (int)ent1.getValue();
        }
      }
    );
    return entries;
  }


  // 出現回数Top20のHashMapを作成
  HashMap<String, Integer> getTop20(ArrayList list){
    HashMap<String, Integer> result = new HashMap<String, Integer>();

    for(int i=0; i<20; i++){
      Map.Entry ent = (Map.Entry)list.get(i);
      result.put( (String)ent.getKey(), (Integer)ent.getValue() );
    }

    return result;
  }

}

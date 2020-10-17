PrintWriter output;
String[] resource;
String str = "";
String out = "";
void setup() {
  resource = loadStrings("n.txt");
  for (int i = 0; i < resource.length; i++) {
    str += resource[i];
  }
  String[] sentence = split(str, '.');
  str = "";
  String[] resource2 = loadStrings("x.txt");
  for (int i = 0; i < resource2.length; i++) {
    str += resource2[i] + "\n";
  }
  String[] words = split(str, '\n');
  int y = 0;
  for (int x = 0; x != words.length-1; x++) {
    for (int i = 0; i != sentence.length-1; i++) {
      if (sentence[i].indexOf(words[x]) > -1 && sentence[i].length() > 100) {
        out += sentence[i] + "\n";
        output = createWriter(y + ".txt");
        output.println(out);
        output.flush();
        output.close();
        y++;
        break;
      }
    }

    out = "";
  }




  exit();
}

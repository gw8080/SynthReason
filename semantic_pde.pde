PrintWriter outputx;
int chunksize = 50;
void setup()
{
  String[] coolw = loadStrings("reason.txt");
  String coolstr = "";
  for (int i = 0; i < coolw.length; i++)
  {
    coolstr += coolw[i];
  }
  String[] enx = split(coolstr, " ");
  String str = "", str2 = "";
  for (int x = 0; x < enx.length; x++)
  {
    if (enx[x].length() > 4) {
      str += enx[x] + " ";
    }
    str2 += enx[x] + " ";
  }


  String[] eny = split(str, " ");// guide
  String[] enz = split(str2, " ");// full
  int count = 0;
  float r = random(enx.length-chunksize);
  for (int j = round(r); j < eny.length - chunksize - 1; j++) {
    for (int i = 0; i < enz.length - chunksize - 1; i++) {
      int a = chunksize;
      String output = "";
      for (int f = 0; f != a; f++) {
        output += enz[i+f] + " ";
        if (str.indexOf(enz[i+f]) > -1) {
          str = str.replace( eny[j] + " " + eny[j+1], eny[j] + "$$" +  output + "$$" + eny[j+1]);
          break;
        }
      }
      count++;
    }
  }
  outputx = createWriter("test.txt");
  outputx.println(str);
  outputx.println();
  outputx.println();
  outputx.flush();
  outputx.close();
  exit();
}

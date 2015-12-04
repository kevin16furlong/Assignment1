
class Temp
{
  int year;
  float cold;
  float hot;
  Temp(String line)
  {
    String[] fields = line.split(",");
   
    year = Integer.parseInt(fields[0]);
    cold = Float.parseFloat(fields[1]);
    hot = Float.parseFloat(fields[2]);
  }
}

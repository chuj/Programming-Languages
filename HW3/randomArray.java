import java.util.Random;
import java.util.Arrays;

public class randomArray{
   
   public static void main(String[] args) {
      int[] array = new int[500];
      for (int i = 0; i < 500; i++){
         Random rand = new Random();
         int n = rand.nextInt(100) + 1;
         array[i] = n;
      }
      System.out.println(Arrays.toString(array));
   }

}
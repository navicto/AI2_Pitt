
import java.awt.List;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;
//import java.util.Arrays;
public class TimeOperations {
	
	public static void main(String[] args)  {
		System.out.println("whatup");
		Calendar calendar = Calendar.getInstance();
		long t1 = calendar.getTimeInMillis();
		calendar.setTimeInMillis(t1);
		long days = TimeUnit.MILLISECONDS.toDays(t1);
		long months = days/30;
		
		System.out.println("today in millis: "+t1);
		
		long year = TimeUnit.MILLISECONDS.convert(30*12, TimeUnit.DAYS);
		long minus05years = t1-year/2;
		long minus1years = t1-year;
		long minus2years = t1-year*2;
		System.out.println("6 months ago"+minus05years);
		System.out.println("12 months ago"+minus1years);
		System.out.println("24 months ago"+minus2years);
		 
		String[] list = {"1","2","3"};
		java.util.List<String> lista = Arrays.asList(list) ;
		int has = Arrays.binarySearch(list, "2");
		System.out.println(lista);

		
		
	}

}

package detailedfind;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.FetchOptions;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.jdo.PersistenceManager;

public class AddCategoryFieldServlet extends HttpServlet {
  /**
	 * added per Eclipse error
	 */

	private static final long serialVersionUID = 1L;

@Override
  public void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws IOException 
    {
		    /*
		    UserService userService = UserServiceFactory.getUserService();
		    User user = userService.getCurrentUser();
		    Date date = new Date();
		    */
	
	    String categoryName = req.getParameter("categoryName");
		   	System.out.print("AddCategoryFieldServlet: categoryName = ");
		   	System.out.println(categoryName);

	    String fieldValue = req.getParameter("fieldValue");
		   	System.out.print("AddCategoryFieldServlet: fieldValue = ");
		   	System.out.println(fieldValue);
		   	
		String filterMinMaxValue = req.getParameter("filterMinMax");
		   	System.out.print("AddCategoryFieldServlet: filterMinMax = ");
		   	System.out.println(filterMinMaxValue);
	   	
		String filterCheckboxValue = req.getParameter("filterCheckbox");
		   	System.out.print("AddCategoryFieldServlet: filterCheckbox = ");
		   	System.out.println(filterCheckboxValue);
	
		String filterTextValue = req.getParameter("filterText");
		   	System.out.print("AddCategoryFieldServlet: filterText = ");
		   	System.out.println(filterTextValue);
		   	
		if( filterMinMaxValue == null && filterCheckboxValue == null)
		{
		   	System.out.print("AddCategoryFieldServlet: no filter selected, therefore select text filter ");
		   	filterTextValue = "Y";
		}

		/*
		 *  Create a Schema Entity if it doesn't exist
		 */

		Key categoryKey = KeyFactory.createKey("Schema", categoryName);
			System.out.print( "AddCategoryFieldServlet: categoryKey = " );
			System.out.println( categoryKey );

	    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

	    Entity schema;
		try {
			schema = datastore.get(categoryKey);			/* get Schema Entity from datastore */
			
			long fields = (long)schema.getProperty("Fields");
			fields++;
		    
		    String fieldName = "FieldName" + fields; 
		    String filterMinMaxName = "FilterMinMax" + fields; 
		    String filterCheckboxName = "FilterCheckbox" + fields; 
		    String filterTextName = "FilterText" + fields; 
			   	System.out.print("AddCategoryFieldServlet: Fields = ");
			   	System.out.println(fields);
			   	System.out.print("AddCategoryFieldServlet: fieldName = ");
			   	System.out.println(fieldName);
			   	System.out.print("AddCategoryFieldServlet: fieldValue = ");
			   	System.out.println(fieldValue);

			schema.setProperty("Fields", fields);
			
		    schema.setProperty(fieldName, fieldValue);
		    schema.setProperty(filterMinMaxName, filterMinMaxValue);
		    schema.setProperty(filterCheckboxName, filterCheckboxValue);
		    schema.setProperty(filterTextName, filterTextValue);

		    datastore.put(schema);
		    
		    /* add this field to all existing records */
		    
		    System.out.println( "categoryName = " + categoryName );
			String itemKind = categoryName;
			
			/* debug */ System.out.print( "itemKind: " );
			/* debug */ System.out.println( itemKind );
			    
		    /* debug */ System.out.println( schema.getProperty( fieldName ) );
		    /* debug */ System.out.print( "fieldName: " );
		    /* debug */ System.out.println( schema.getProperty( fieldName ) );
		    /* debug */ System.out.print( "fieldName: " );
		    /* debug */ System.out.println( schema.getProperty( fieldName ).toString() );

			/* QUERY ---------------------------------------- */
			
			Query query = new Query(itemKind);
			/*
				.addSort(schema.getProperty( fieldName ).toString(), Query.SortDirection.ASCENDING);
			*/

			/* debug */ System.out.println( "-------------------------------------------------------" );
			/* debug */ System.out.println( "dc: query" );
			/* debug */ System.out.println( query );
				
			/* DatastoreService datastore = DatastoreServiceFactory.getDatastoreService(); */
			
			List<Entity> items = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
				System.out.println( "dc: items" );
				System.out.println( items );
			
			if(items.isEmpty())
			{
				System.out.println( "AddCategoryFieldServlet: no items in the " + fieldName + " database category");
			}
			else
			{
				/* add field to each item in category ----------------------------------------------------------------- */
				for (Entity item : items)
				{
				    item.setProperty(fieldValue, "added");
				    datastore.put(item);
				    System.out.println("AddCategoryFieldServlet: added field " + fieldValue + " to item " + item);
				}
			}
		    
		} catch (EntityNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			long fields = 1;
		   	System.out.println("AddCategoryFieldServlet: no Schema");
		   	schema = new Entity("Schema",categoryName);
		   			    
		    String fieldName = "FieldName" + fields; 
		    String filterMinMaxName = "FilterMinMax" + fields; 
		    String filterCheckboxName = "FilterCheckbox" + fields; 
		    String filterTextName = "FilterText" + fields; 
			   	System.out.print("AddCategoryFieldServlet: Fields = ");
			   	System.out.println(fields);
			   	System.out.print("AddCategoryFieldServlet: fieldName = ");
			   	System.out.println(fieldName);
			   	System.out.print("AddCategoryFieldServlet: fieldValue = ");
			   	System.out.println(fieldValue);

			schema.setProperty("Fields", fields);
			
		    schema.setProperty(fieldName, fieldValue);
		    schema.setProperty(filterMinMaxName, filterMinMaxValue);
		    schema.setProperty(filterCheckboxName, filterCheckboxValue);
		    schema.setProperty(filterTextName, filterTextValue);
		    
		    datastore.put(schema);
		}

	   	System.out.println("AddCategoryFieldServlet: PMF");
		PersistenceManager pm = PMF.get().getPersistenceManager();

	    resp.sendRedirect("/dc.jsp?categoryName=" + categoryName);

/*
 * 	    resp.sendRedirect("/dc.jsp");
 */

    }
}


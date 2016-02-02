import java.util.HashMap
import java.util.ArrayList

public HashMap<int, HashMap<String, int>> recipes = new HashMap();
public String returnSuccess = "";
public String returnFailure = "";

public void init() {
	//Get all lists from the db
	//all by id
	ArrayList db;
	Iterator iter = db.iterator();
	
	
    while (iter.hasNext()) {
    	int id = iter.next();
    	HashMap<String, int> ingredients = getIngredients(id);
    	recipes.put(id, ingredients);
    }
}

public void getIngredients(int id) {
	//get the db stuff using the id
	//tuple of tag, then amount
	ArrayList<Tuple> db;
	Iterator iter = db.iterator();
	HashMap<String, int> ingredients = new HashMap();
    while (iter.hasNext()) {
    	Tuple tup = db.next();
    	ingredients.put(tup.get(0), tup.get(1));
    }
    return ingredients;
}

//items is a string of each item they have, with the amount next to it
public boolean makeRecipe(int id, HashMap<String, int> inventory) {
	HashMap<String, int> tempRecipe = recipes.get(id);

	Iterator iter = tempRecipe.keySet().iterator();
	while (iter.hasNext()) {
		String recipeTag = iter.next();
		int recipeAmount = tempRecipe.get(recipeTag);
		int invAmount = inventory.get(recipeTag);
		if (recipeAmount <= invAmount) {
			returnSuccess += recipeTag + ":" + String.valueOf(recipeAmount);
		} else {
			returnFailure += recipeTag + ":" + String.valueOf(recipeAmount - invAmount);
		}
		iter.remove();
	}

	return returnFailure.equals("");


}



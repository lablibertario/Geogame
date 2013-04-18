package model;

/**
 * UserProfile is used to create simple user profiles.
 * @author Mathieu DABEK & Benjamin DUPRAT
 * @version 1.0
 * @see User
 */
public class UserProfile 
{
	private String _id;
	private int _score;
	
	private User _user;
	
	public UserProfile(String id, int score)
	{
		_id = id;
		_score = score;
		
	}

	public String getId() 
	{
		return _id;
	}

	public void setId(String id) 
	{
		this._id = id;
	}

	public int getScore() 
	{
		return _score;
	}

	public void setScore(int score) 
	{
		this._score = score;
	}

	public User getUser() 
	{
		return _user;
	}

	public void setUser(User user) 
	{
		this._user = user;
	}
	
	
	
	
}

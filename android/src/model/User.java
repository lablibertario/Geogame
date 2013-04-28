package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * User is used to create simple users.
 * @author Mathieu DABEK & Benjamin DUPRAT
 * @version 1.0
 * @see UserProfile
 */
public class User 
{
	private String _id;
	private String _username;
	private String _encryptedPassword;
	private String _email;
	private Date _createdAt;
	private Date _updatedAt;
	private ArrayList<UserComment> _userComments;
	private ArrayList<UserPicture> _userPictures;
	private UserProfile _userProfile;
	private boolean _isEnabled;
	
	private UserProfile _profile;
	
	public User(String id, 
				String username, 
				String encryptedPassword,
				String email,
				Date createdAt,
				Date updatedAt,
				boolean isEnabled)
	{
		_id = id;
		_username = username;
		_encryptedPassword = encryptedPassword;
		_email = email;
		_createdAt = createdAt;
		_updatedAt = updatedAt;
		_isEnabled = isEnabled;
	}

	public String getId() 
	{
		return _id;
	}

	public void setId(String id) 
	{
		this._id = id;
	}

	public String getUsername() 
	{
		return _username;
	}

	public void setUsername(String username) 
	{
		this._username = username;
	}

	public String getEncryptedPassword() 
	{
		return _encryptedPassword;
	}

	public void setEncryptedPassword(String encryptedPassword) 
	{
		this._encryptedPassword = encryptedPassword;
	}

	public String getEmail() 
	{
		return _email;
	}

	public void setEmail(String email) 
	{
		this._email = email;
	}

	public Date getCreatedAt() 
	{
		return _createdAt;
	}

	public void setCreatedAt(Date createdAt) 
	{
		this._createdAt = createdAt;
	}

	public Date getUpdatedAt() 
	{
		return _updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) 
	{
		this._updatedAt = updatedAt;
	}

	public boolean isEnabled() 
	{
		return _isEnabled;
	}

	public void setEnabled(boolean isEnabled) 
	{
		this._isEnabled = isEnabled;
	}

	public UserProfile getProfile() 
	{
		return _profile;
	}

	public void setProfile(UserProfile profile) 
	{
		this._profile = profile;
	}
	
	
	
}

package model;

import java.util.Date;

/**
 * Waypoint is used to create simple waypoints.
 * @author Mathieu DABEK & Benjamin DUPRAT
 * @version 1.0
 */
public class Waypoint 
{
	private String _id;
	private String _name;
	private int _point;
	private String _location;
	private Date _createdAt;
	private Date _updatedAt;
	private boolean _isEnabled;
	private String _picture;
	private String _description;
	
	public Waypoint(String id, 
			String name, 
			int point,
			String location,
			Date createdAt,
			Date updatedAt,
			boolean isEnabled,
			String picture,
			String description)
	{
		_id = id;
		_name = name;
		_point = point;
		_location = location;
		_createdAt = createdAt;
		_updatedAt = updatedAt;
		_isEnabled = isEnabled;
		_picture = picture;
		_description = description;
	}

	public String getId() 
	{
		return _id;
	}

	public void setId(String id) 
	{
		this._id = id;
	}

	public String getName() 
	{
		return _name;
	}

	public void setName(String name) 
	{
		this._name = name;
	}

	public int getPoint() 
	{
		return _point;
	}

	public void setPoint(int point) 
	{
		this._point = point;
	}

	public String getLocation() 
	{
		return _location;
	}

	public void setLocation(String location) 
	{
		this._location = location;
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

	public String getPicture() 
	{
		return _picture;
	}

	public void setPicture(String picture) 
	{
		this._picture = picture;
	}

	public String getDescription() 
	{
		return _description;
	}

	public void setDescription(String description) 
	{
		this._description = description;
	}
	
	
	

	
}

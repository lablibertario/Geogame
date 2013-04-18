package model;

import java.util.ArrayList;
import java.util.Date;

/**
 * Category is used to create simple categories.
 * @author Mathieu DABEK & Benjamin DUPRAT
 * @version 1.0
 * @see Waypoint
 */
public class Category 
{
	/** Category's ID. */
	private String _id;
	
	/** Category's name. */
	private String _name;
	
	/** Category's created date. */
	private Date _createdAt;
	
	/** Category's updated date. */
	private Date _updatedAt;
	
	/** Category's enabled. */
	private boolean _isEnabled;
	
	/** Category's waypoints. */
	private ArrayList<Waypoint> _waypoints;
	
	/**
	 * Create a new Category entity with specified parameters.
	 * @param id Entity's id.
	 * @param name Entity's name.
	 * @param createdAt Entity's createdAt.
	 * @param updatedAt Entity's updatedAt.
	 * @param isEnabled Entity's isEnabled.
	 * @param waypoints Entity's waypoints.
	 */
	public Category(String id,
			String name,
			Date createdAt,
			Date updatedAt,
			boolean isEnabled,
			ArrayList<Waypoint> waypoints)
	{
		_id = id;
		_name = name;
		_createdAt = createdAt;
		_updatedAt = updatedAt;
		_isEnabled = isEnabled;
		_waypoints = waypoints;
	}

	/**
	 * Return the entity's ID.
	 * @return ID as a String.
	 */
	public String getId() 
	{
		return _id;
	}

	/**
	 * Set the entity's ID with a specified new one.
	 * @param ID New ID as a String.
	 */
	public void setId(String id) 
	{
		this._id = id;
	}
	
	/**
	 * Return the entity's name.
	 * @return Name as a String.
	 */
	public String getName() 
	{
		return _name;
	}

	/**
	 * Set the entity's name with a specified new one.
	 * @param name New name as a String.
	 */
	public void setName(String name) 
	{
		this._name = name;
	}

	/**
	 * Return the entity's createdAt.
	 * @return CreatedAt as a Date.
	 */
	public Date getCreatedAt() 
	{
		return _createdAt;
	}

	/**
	 * Set the entity's createdAt with a specified new one.
	 * @param createdAt New createdAt as a Date.
	 */
	public void setCreatedAt(Date createdAt) 
	{
		this._createdAt = createdAt;
	}

	/**
	 * Return the entity's updatedAt.
	 * @return UpdatedAt as a Date.
	 */
	public Date getUpdatedAt() 
	{
		return _updatedAt;
	}

	/**
	 * Set the entity's updatedAt with a specified new one.
	 * @param updatedAt New updatedAt as a Date.
	 */
	public void setUpdatedAt(Date updatedAt) 
	{
		this._updatedAt = updatedAt;
	}

	/**
	 * Return the entity's isEnabled.
	 * @return IsEnabled as a boolean.
	 */
	public boolean isEnabled() 
	{
		return _isEnabled;
	}

	/**
	 * Set the entity's isEnabled with a specified new one.
	 * @param isEnabled New isEnabled as a boolean.
	 */
	public void setEnabled(boolean isEnabled) 
	{
		this._isEnabled = isEnabled;
	}

	/**
	 * Returns the waypoints of the category.
	 * @return Waypoints of the category.
	 */
	public ArrayList<Waypoint> getWaypoints() 
	{
		return _waypoints;
	}

	/**
	 * Set waypoints of the category.
	 * @param waypoints List of waypoints.
	 */
	public void setWaypoints(ArrayList<Waypoint> waypoints) 
	{
		this._waypoints = waypoints;
	}
	
	

}

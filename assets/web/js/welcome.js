$( document ).ready(function()
{
	//Handling enter keydown during login to trigger form submit	
	$("form").keydown(function(e)
	{		
		if(e.keyCode == 13)
		{
			$("form").first().submit();
		}
	});
});
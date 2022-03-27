<?php
$res=$conn->query("SELECT `id group`,`Название группы` FROM `group`");
while($row=$res->fetch_assoc()){
	echo '
	<div class="form-check">
		<input class="form-check-input" type="radio" name="group_id" id="exampleRadios'.$row['id group'].'" value="'.$row['id group'].'" checked>
		<label class="form-check-label" for="exampleRadios'.$row['id group'].'">
			'.$row['Название группы'].'
		</label>
</div>
';

}



?>
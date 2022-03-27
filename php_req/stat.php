<?php
$res=$conn->query("CALL `Статистика вакцин`();");

echo '
					<div class="row pb-2 pt-3 border-bottom btn-primary">
						<div class="col-sm">
						Название вакцины	
						</div>
						<div class="col-sm">
						Колличество вакцинаций
						</div>
					</div>
						';

				while($row=$res->fetch_assoc()){
						echo '
					<div class="row pb-1 btn-success">
						<div class="col-sm">
						  '.$row["Название вакцины"].'
						</div>
						<div class="col-sm">
						'.$row["Колличество вакцинаций"].'
						</div>
					</div>
						';

				}
			?>

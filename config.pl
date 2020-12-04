open CONFIG,"config.js";#配置文件
open TIMER,"timer.bak";#自由模式文件
open TIMERCOM,"timer_common.bak";#普通模式文件
open OUTTC,">timer.html";
open OUTT,">timer_common.html";
print "waiting......\n";
while(<CONFIG>){
	$aff_name=$1 if(/var name_aff = "(.+)?"/);
	$neg_name=$1 if(/var name_neg = "(.+)?"/);
	next if(/^>>>/);
	$name_competition = $1 if(/比赛名称 = "(.+?)"/);
	$row=$1 if(/第(\d+)行;/);
	if(/环节(\d+) = (.+?);(普通);(.+?);(.+?);(.+?);/){
		$common{$row}{$1}{name} = $2;#普通模式
		$common{$row}{$1}{mode} = $3;
		$common{$row}{$1}{team} = $4;
		$common{$row}{$1}{hour} = $5;
		$common{$row}{$1}{notes} = $6;
	}
	if(/环节(\d+) = (.+?);(自由);(.+?);/){
		$common{$row}{$1}{name} = $2;#自由模式
		$common{$row}{$1}{mode} = $3;
		$common{$row}{$1}{notes} = $4;
	}
}
sub Printbutton{#生成赛制
	for $family (sort {$a<=>$b} keys %common){
		print OUTT"<div class=\"btn-group1 ml-3 mt-3\" role=\"group\">\n";
		for(sort {$a<=>$b} keys %{ $common{$family}}){
			if($common{$family}{$_}{mode}eq"普通"){
				print OUTT"<button type=\"button\" ";
				print OUTT"class=\"btn btn-success\" " if($common{$family}{$_}{team}eq$aff_name);
				print OUTT"class=\"btn btn-warning\" " if($common{$family}{$_}{team}eq$neg_name);
				print OUTT"onclick=\"restart_with_time$common{$family}{$_}{hour};" if($common{$family}{$_}{hour});
				print OUTT"change_cur(1);\"" if($common{$family}{$_}{team}eq$aff_name);
				print OUTT"change_cur(0);\"" if($common{$family}{$_}{team}eq$neg_name);
				print OUTT">$common{$family}{$_}{name}<br><small>$common{$family}{$_}{notes}</small></button>\n";
			}
			if($common{$family}{$_}{mode}eq"自由"){
				print OUTT"<a class=\"btn btn-primary\" href=\"./timer.html\" target=\"_self\">$common{$family}{$_}{name}<br><small>$common{$family}{$_}{notes}</small></a>\n";
			}
		}
		print OUTT"</div><!--结尾-->\n";
	}
}
while(<TIMERCOM>){
	if(/<h3 style="font-weight: bold;">/){#修改比赛名称
		print OUTT "$`$&$name_competition</h3>\n";
	}
	#删除旧赛制
	elsif(/<\/small><\/button>|<\/small><\/a>/|/<div class="btn-group1 ml-3 mt-3" role="group">|<\/div><!--结尾-->/){next;}
	elsif(/<!--赛制-->/){
		print OUTT$_;
		Printbutton();#添加赛制
	}
	else {print OUTT $_;}
}

while(<TIMER>){
	if(/<h3 style="font-weight: bold;">/){#修改比赛名称
		print OUTTC "$`$&$name_competition</h3>\n";
	}
	else {print OUTTC $_;}
}
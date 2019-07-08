/*将child的性别、年龄的信息attach到母亲的观测值中*/
use "C:\Users\verla\Desktop\7816\CenACS\Cen1980.dta" 
/*将孩子的性别按照出生早晚顺序归类到同一个家庭的观测值中*/
tab related
tab related,nolabel
keep if related==301
keep age sex serial
sort serial -age
by familycode: gen id=_n
drop age
reshape wide sex, i(serial) j(id)
save "C:\Users\verla\Desktop\计量paper孩子性别.dta"
 
/*提取母亲的信息*/
use "C:\Users\verla\Desktop\7816\CenACS\Cen1980.dta" 
tab related,nolabel
tab related
tab sex
tab sex,nolabel
/*只保留是家长或者家长的配偶的女性*/
keep if (related==101|related==201) & (sex==2)
keep age sex educrecd race raced labforce wkswork1 workedyr hhincome inctot ftotinc incwage hrswork1 serial
save "C:\Users\verla\Desktop\计量母亲的信息.dta"
joinby serial using "C:\Users\verla\Desktop\计量paper孩子性别.dta"
save "C:\Users\verla\Desktop\计量母亲和孩子的信息.dta"

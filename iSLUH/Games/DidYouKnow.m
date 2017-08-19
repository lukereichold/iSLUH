#import "DidYouKnow.h"
#import <stdlib.h>
#import <time.h>
#import "UIColor+SLUHCustom.h"

@interface DidYouKnow ()

@property (nonatomic, strong) IBOutlet UIImageView *sluhImageView;
@property (nonatomic, strong) IBOutlet UILabel *funFactLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *facts;

@end

@implementation DidYouKnow

- (void)viewDidLoad {
	
	self.navigationItem.title = @"Did You Know?";
    [self createBackgroundGradientWithTopColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] bottomColor:[UIColor sluhWarmGrey]];

	[self.titleLabel setFont:[UIFont fontWithName:@"Bree Serif" size:20]];
	
	[self.sluhImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
	[self.sluhImageView.layer setBorderWidth: .5];
    
    self.facts =  [NSMutableArray arrayWithObjects: @"SLUH is the oldest private Catholic high school west of the Mississippi River.",
                   @"SLUH has the largest pool hall in the State of Missouri.",
                   @"SLUH has the largest collection of artwork either of St. Louis or by St. Louis artists.",
                   @"SLUH provides more than $2,000,000 per year in direct financial assistance to qualified students.",
                   @"Since 2005, SLUH students have achieved 31 perfect ACT scores, two top SAT-2 scores and one top PSAT score.",
                   @"SLUH, which offers AP courses in 19 disciplines, earned the highest AP ranking in Missouri in 2005-06.",
                   @"One-third of SLUH's student body participates in the voluntary community service program.",
                   @"The Jesuit motto, 'Ad Majorem Dei Gloriam' or A.M.D.G., is Latin for 'For the Greater Glory of God'.",
                   @"SLUH offers more than 50 student clubs and activities for a variety of interests.",
                   @"SLUH is one of 59 high schools nationwide in the Jesuit Secondary Education Association.",
                   @"Students at SLUH can choose from more than 90 elective courses.",
                   @"SLUH, which was founded in 1818, moved to its current campus in 1924.",
                   @"SLUH's average class size is 20, compared to 30 one decade ago.",
                   @"SLUH draws students from 85 zip codes and 96 elementary and middle schools.",
                   @"'Magis', a hallmark of Jesuit education, is a call to strive for excellence in all things.",
                   @"SLUH is the top feeder school for Kenrick-Glennon Seminary in St. Louis.",
                   @"St. Ignatius of Loyola founded the Society of Jesus, known as the Jesuits, in 1540.",
                   @"Today more than 20,000 Jesuits are serving the Church in 112 nations on six continents.",
                   @"99% of SLUH graduates continue on to four-year colleges and universities.",
                   @"SLUH's Class of 2009 was offered a one-year total of $7-million in college scholarships. The total value of scholarships accepted was $2-million.",
                   @"SLUH enhances its curriculum with computer labs, laptop carts, classroom projectors and SmartBoards.",
                   @"SLUH offers advanced technology courses, such as Web Design, Artificial Intelligence, iPhone App Development, and AP Computer Science.",
                   @"Quarterly tuition at SLUH (formerly St. Louis Academy) was $12 during its founding year.",
                   @"The Society of Jesus is the largest religious order of the Roman Catholic Church.",
                   @"More than 1.3 million students currently attend Jesuit schools at all levels worldwide.",
                   @"SLUH's strong athletic tradition continues with 47 teams in 12 sports and 6 club sports.",
                   @"The Billiken is a symbol of good luck that became a national craze in the early 1900s.",
                   @"SLUH's foreign language offerings include Chinese, French, Greek, Latin, Russian and Spanish.",
                   @"More than 90 percent of SLUH faculty members have advanced degrees.",
                   @"All SLUH seniors perform 120 hours of community service outside of school each January.",
                   @"At age 32, Ed Macauley '45 was the youngest person enshrined into the Basketball Hall of Fame.",
                   @"Renowned humanitarian Dr. Tom Dooley graduated from SLUH in 1944.",
                   @"Prior to 1924, SLUH was comprised of St. Louis Academy and Loyola Hall.",
                   @"SLUH's Joseph Schulte Theater is a 610-seat, state-of-the-art facility that was built in 1995.",
                   @"SLUH's original 1924 main campus building is in the shape of the letter 'I' for Ignatius.",
                   @"Nearly 90% of the student body and 60% of the faculty participate in SLUH's intramural program.",
                   @"Fr. Richard Bailey, S.J., past president, principal and superior, founded CASHBAH and co-created Senior Project.",
                   @"Fr. Pedro Arrupe, S.J., former Superior General of the Jesuits, coined the term 'Men for Others.'",
                   @"St. Francis Xavier was a co-founder of the Society of Jesus and pioneering missionary to Asia.",
                   @"Former SLUH President Fr. Paul Sheridan, S.J. founded Boys Hope Girls Hope in 1977.",
                   @"Former SLUH principal Fr. William Bowdern, S.J. '13 was the priest/exorcist in the case that inspired the film The Exorcist.",
                   @"Bro. Thornton, S.J. ran the bookstore in the 1980s and early '90s with his canine comrade, Doxie.",
                   @"SLUH's rec room is named after Fr. Martin Hagan, S.J., longtime theology teacher and rifle club moderator.",
                   @"Fr. Van de Velde, S.J., a 19th century president of SLUH (then SLU), became Bishop of Chicago.",
                   @"Fr. Clark, SLUH administrator and teacher in the 1930s, began Dismas House for prisoners returning to society. His story was captured in the feature film, Hoodlum Priest.",
                   @"The tornado of 1927 severely damaged SLUH's building; luckily there were no serious injuries.",
                   @"Scholastic describes a Jesuit Seminarian from the time he takes his First Vows until his Last Vows.",
                   @"The Superior General, Father Adolfo Nicolas, is the head of the worldwide Society of Jesus organization headquartered in Rome.",
                   @"SLUH's academic administration space was formerly the auditorium and, before that, the gymnasium.",
                   @"In 1979, Fr. Ralph Houlihan, S.J. '52 ran both SLUH and Regis in Denver simultaneously as CEO.",
                   @"SLUH's Fathers' Club dates from 1938 and was originally known as the 'St. Louis U. High Club.'",
                   @"SLUH's Mothers' Club was founded in 1927 to help raise funds to repair tornado damage from that year.",
                   @"Fr. John Divine, S.J. began SLUH's Senior Follies and Alumni Association in 1945 and 1947, respectively.",
                   @"Every Jesuit performs the 30-day Spiritual Exercises of St. Ignatius at least twice in his life.",
                   @"Fr. Bill Doyle, S.J. '42 produced the statue of St. Ignatius that graces SLUH's Alumni Park.",
                   @"The Dauphin, SLUH's yearbook, began in 1922 under the direction of Fr. William McCabe, S.J.",
                   @"The first Jesuit administrator of SLUH in 1829 (then St. Louis College) was Fr. Van Quickenborne.",
                   @"The first principal of SLUH on Oakland in 1924 was Fr. W.J. Ryan, S.J., affectionately known as 'Bulldog'.",
                   @"Dr. James Robinson '32, the namesake of the school's library, taught history at SLUH for 42 years.",
                   @"By special arrangement, nuns from local hospitals attended SLUH in the 1920s and '30s after school hours.",
                   @"Chouteau, Mullanphy and Clark were among the 16 family names listed on the first student roster.",
                   @"Appointed by President Dwight Eisenhower, William Quinn '36 was the first governor of Hawaii.",
                   @"SLUH's building, Backer Memorial, was a gift in 1924 from the wife of George Backer (SLU Class of 1869).",
                   @"SLUH's basement was dug after the school was built, and the rec room took shape in the late 1940s.",
                   @"Blessed Peter Faber, co-founder of the Jesuits, was the first Companion of Jesus to be ordained a priest.",
                   @"As football coach from 1959-87, Paul Martel earned a 200-65-8 record and one state championship.",
                   @"The first Jesuit school for boys opened in Messina, Sicily, in 1548.",
                   @"'Ratio Studiorum' refers to the document that formally established the Jesuit educational system in 1599.",
                   @"The first faculty at SLUH on Oakland in 1924 consisted of 14 priests, 6 scholastics and 16 lay teachers.",
                   @"After students cheered Cardinal Pacelli (later Pius XII) during a visit to SLUH in 1936, he gave them a free day!",
                   @"'Religioni et Bonis Artibus,' which encircles the SLUH seal, is Latin for 'Religion and the Fine Arts.'",
                   @"SLUH dedicates two minutes of reflective silence each day to the Ignatian 'Examen of Consciousness.'",
                   @"SLUH offers daily mass at 7:20 a.m. on regularly scheduled days.",
                   @"Paul Owens, SLUH Principal from 1984-95, was the first non-Jesuit to serve in that position.",
                   @"David Laughlin, current SLUH President who began in 2005, is the first non-Jesuit to serve in that role.",
                   @"Fr. Gerry Sheahan served the longest term as a Jesuit principal (1955-67) in the history of SLUH.",
                   @"St. John's College, a Jesuit secondary school in Belize, is part of the Missouri Province.",
                   @"There are 207 Jesuit institutions of higher education worldwide.",
                   @"The average age of all Jesuits worldwide is 54.",
                   @"There are 165 Jesuit primary schools worldwide.",
                   @"There are 93 Jesuit provinces worldwide. Ten are in the U.S.",
                   @"There are 600,278 students in Jesuit higher education worldwide.",
                   @"There are 567,505 students in Jesuit secondary schools worldwide.",
                   @"There are 4,010 Jesuit teachers/administrators worldwide.",
                   @"There are 125,032 non-Jesuit teachers/administrators in Jesuit schools worldwide.",
                   @"The average age of Jesuit scholastics worldwide is 26.",
                   @"There are 472 Jesuit secondary schools worldwide.",
                   @"There are 78 Jesuit technical or professional schools worldwide.",
                   @"There have been 29 Jesuit General Superiors in the history of the Society of Jesus.",
                   @"Sixty-nine countries have one or more Jesuit schools.",
                   @"In 1970, the Jesuit Secondary Education Association (JSEA) was formed.",
                   @"In 1983, Peter-Hans Kolvenbach, S.J. became the 29th Superior General of the Society of Jesus.",
                   @"In 1965, Pedro Arrupe, S.J. became the 28th Superior General of the Society of Jesus.",
                   @"The Society of Jesus was restored worldwide in 1814 after suppression by Pope Clement XIV in the late 18th century.",
                   @"St. Edmund Campion converted from Anglicanism and was hanged, drawn and quartered in London on December 1, 1581.",
                   @"Blessed Miguel Pro is the Mexican Jesuit famous for calling out 'Viva Cristo Rey' just before he was executed by the Mexican government in 1927.",
                   @"St. Stanislaus Kostka, a Polish Jesuit Scholastic known for his piety, died at the age of 18 in 1567.",
                   @"A scholar and Cardinal of the Church, St. Robert Bellarmine was an Italian Jesuit and spiritual father of St. Aloysius Gonzaga.",
                   @"St. John de Brebeuf was a French Jesuit who worked and was martyred on the Canadian frontier in the 17th century.",
                   @"A French Jesuit known for his skill as a preacher, St. John Francis Regis established hostels for prostitutes trying to escape the trade and worked with plague victims in Toulouse.",
                   @"St. Joseph Pignatelli was a Spanish Jesuit who led and inspired the Jesuits during the 41 years of the suppression of the Society of Jesus (1773 - 1814).",
                   @"A Dutch Jesuit and Doctor of the Church, St. Peter Canisius led the Counter-Reformation in German territory and addressed the Council of Trent on the sacrament of the Holy Eucharist.",
                   @"St. Nicholas of Myra, whose feast is celebrated on December 6th, was Bishop of Myra in the fourth century.",
                   @"Diego Lainez succeeded Ignatius as the second superior general of the Society and played a major role at the Council of Trent.",
                   @"Father Peter Verhaegen, the first president of St. Louis University, was responsible for organizing the Jesuits of the Missouri Province.",
                   @"Father John Baptist Smedts was the first Jesuit ordained west of the Mississippi River.",
                   @"SLUH was founded in 1818, the same year Mary Shelley's 'Frankenstein' was published.",
                   @"SLUH was founded in 1818, the same year Frederick Douglass was born.",
                   @"In 1953, SLUH became the first high school in Missouri to play football against a black public school (Sumner).",
                   @"The Jesuit Volunteer Corps (JVC) began on February 28, 1957.",
                   @"St. Ignatius of Loyola arrived in Paris on February 2, 1528 to begin studies at the University of Paris.",
                   @"The total U.S. Jesuit high school enrollment is currently 44,807.",
                   @"More than 10 percent of the 110th U.S. Congress are Jesuit alums.",
                   @"The Missouri Province, one of 10 Jesuit provinces in the U.S., consists of Missouri, Kansas, Oklahoma, Colorado, and part of Illinois, as well as the country of Belize in Central America.",
                   @"Graduates of the Class of 2009 were accepted at 195 different colleges and universities throughout the U.S. and are attending 88 of these schools.",
                   @"The average ACT score achieved by SLUH's Class of 2010 is 30.1, and their average SAT score is 2002.",
                   @"Pierre Teilhard de Chardin, S.J. was a French paleontologist and philosopher involved in the discovery of the so-called Peking Man.",
                   @"In 1658, Christopher Clavius, S.J. concluded after extensive research that microogranisms caused disease, an antecedent to germ theory.",
                   @"Athanasius Kircher, S.J., an astronomer and mathematician, was one of the most influential teachers of the Renaissance.",
                   @"In 1983, SLUH's library was dedicated to the memory of Dr. James F. Robinson '32, who taught history at SLUH for 42 years.",
                   @"Conversion is defined by the Catechism of the Catholic Church as 'a radical reorientation of the whole life away from sin and evil, and toward God.'",
                   @"Fr. Martin Hagan, S.J., legendary rifle coach at SLUH, was posthumously inducted into the Missouri Sports Hall of Fame in 2010.",
                   @"SLUH baseball coach Steve Nicollerat was inducted into the  Missouri High School Baseball Coaches Association Hall of Fame in 2010.",
                   @"Dan Isom, the Chief of of the St. Louis Metropolitan Police Department, graduated from SLUH in 1985.", nil];

    
	[self shuffleFacts];
    [super viewDidLoad];
}

- (IBAction)shuffleFacts {
	NSLog(@"Shuffling..");
	    
	int random = arc4random() % [self.facts count];
	
	//Formatting the label based on the length of the fact
	self.funFactLabel.text = [self.facts objectAtIndex:random];
    self.funFactLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.funFactLabel setTextColor:[UIColor blackColor]];
	
    CGSize expectedLabelSize = [[self.facts objectAtIndex:random] sizeWithFont:self.funFactLabel.font
										   constrainedToSize:self.funFactLabel.frame.size
											   lineBreakMode:NSLineBreakByWordWrapping];
	
    CGRect newFrame = self.funFactLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
	newFrame.size.width = 300;
    self.funFactLabel.frame = newFrame;
    self.funFactLabel.numberOfLines = 0;
    [self.funFactLabel sizeToFit];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
	if (event.subtype == UIEventSubtypeMotionShake)
	{
		[self shuffleFacts];
	}
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}

- (void)createBackgroundGradientWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.frame;
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

@end
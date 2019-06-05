import UIKit
import WebKit

class ViewController: UITableViewController {

    private var cellCache = [Int: UITableViewCell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cellCache[indexPath.row] {
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { return UITableViewCell() }
        cell.update(with: Cell.ViewModel(htmlString: modelData[indexPath.row], callback: { [weak self] cell in
            tableView.beginUpdates()
            tableView.endUpdates()
            self?.cellCache[indexPath.row] = cell
        }))
        return cell
    }
}

public extension UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

fileprivate let modelData = [
    """
<html><head><link rel="stylesheet" type="text/css" href="https://kivrastatic.com/fonts/museo-sans.css"><style> h1, p, ul {font-family: 'Museo Sans', Helvetica; font-weight: 100;} body { background-color: #F0F2F1; } div {background-color: white;}</style></head><body style="position: static; width: 100%;"><div style="padding: 20px"><p>Hej,</p><p>Tack för att du använder Kivra och bidrar till en mer hållbar värld! Majoriteten av Sveriges största företag skickar nu post via Kivra. En bra nyhet är att du automatiskt kommer få din post digitalt från anslutna avsändare du tidigare fått papperspost från.</p><p>I Kivra får du post såsom kreditupplysningar, fakturor och årsbesked. Varje gång du får ny post får du en avisering varpå du kan logga in och läsa din post var du än befinner dig.</p><p>Tips!</p><ul><li>Under "Meny", "Inställningar", "Myndighetspost" kan du välja att börja ta emot din myndighetspost i Kivra om du inte redan gjort det</li><li>Ladda ner vår app, då får du en pushnotis när du får ny post i Kivra!</li></ul><p></p><p>Du får endast post från avsändare du har en relation till och som inloggad kan du administrera ditt konto om du exempelvis vill ställa om en avsändare till papperspost.</p><p>Frågor om Kivra? Kontakta support@kivra.com</p></div></body></html>
""",
    """
<html><head><meta charset="UTF-8"><style>body { margin: 0; -webkit-font-smoothing: antialiased; } pre { font-family: Courier, monospace; font-size: 2.13vw; line-height: 2.4vw; padding: 1em; margin: 0;} @media screen { pre:not(:last-child) { border-bottom: 1px solid rgba(0,0,0,0.12);} } @media print { pre {page-break-after: always;} }</style></head><body style="position: static; width: 100%;"><pre>Test med &amp; tecken</pre></body></html>
""",
    """
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- FOR THE CURIOUS: This site was made by @thebarrytone. Don't tell my mom. -->

    <title>Motherfucking Website</title>
</head>

<body>
    <header>
        <h1>This is a motherfucking website.</h1>
        <aside>And it's fucking perfect.</aside>
    </header>

        <h2>Seriously, what the fuck else do you want?</h2>

        <p>You probably build websites and think your shit is special. You think your 13 megabyte parallax-ative home page is going to get you some fucking Awwward banner you can glue to the top corner of your site. You think your 40-pound jQuery file and 83 polyfills give IE7 a boner because it finally has box-shadow. Wrong, motherfucker. Let me describe your perfect-ass website:</p>

        <ul>
            <li>Shit's lightweight and loads fast</li>
            <li>Fits on all your shitty screens</li>
            <li>Looks the same in all your shitty browsers</li>
            <li>The motherfucker's accessible to every asshole that visits your site</li>
            <li>Shit's legible and gets your fucking point across (if you had one instead of just 5mb pics of hipsters drinking coffee)</li>
        </ul>

        <h3>Well guess what, motherfucker:</h3>

        <p>You. Are. Over-designing. Look at this shit. It's a motherfucking website. Why the fuck do you need to animate a fucking trendy-ass banner flag when I hover over that useless piece of shit? You spent hours on it and added 80 kilobytes to your fucking site, and some motherfucker jabbing at it on their iPad with fat sausage fingers will never see that shit. Not to mention blind people will never see that shit, but they don't see any of your shitty shit.</p>

        <p>You never knew it, but this is your perfect website. Here's why.</p>

        <h2>It's fucking lightweight</h2>

        <p>This entire page weighs less than the gradient-meshed facebook logo on your fucking Wordpress site. Did you seriously load 100kb of jQuery UI just so you could animate the fucking background color of a div? You loaded all 7 fontfaces of a shitty webfont just so you could say "Hi." at 100px height at the beginning of your site? You piece of shit.</p>

        <h2>It's responsive</h2>

        <p>You dumbass. You thought you needed media queries to be responsive, but no. Responsive means that it responds to whatever motherfucking screensize it's viewed on. This site doesn't care if you're on an iMac or a motherfucking Tamagotchi.</p>

        <h2>It fucking works</h2>

        <p>Look at this shit. You can read it ... that is, if you can read, motherfucker. It makes sense. It has motherfucking hierarchy. It's using HTML5 tags so you and your bitch-ass browser know what the fuck's in this fucking site. That's semantics, motherfucker.</p>

        <p>It has content on the fucking screen. Your site has three bylines and link to your dribbble account, but you spread it over 7 full screens and make me click some bobbing button to show me how cool the jQuery ScrollTo plugin is.</p>

        <p>Cross-browser compatibility? Load this motherfucker in IE6. I fucking dare you.</p>

        <h2>This is a website. Look at it.  You've never seen one before.</h2>

        <p>Like the man who's never grown out his beard has no idea what his true natural state is, you have no fucking idea what a website is. All you have ever seen are shitty skeuomorphic bastardizations of what should be text communicating a fucking message. This is a real, naked website. Look at it. It's fucking beautiful.</p>

        <h3>Yes, this is fucking satire, you fuck</h3>

        <p>I'm not actually saying your shitty site should look like this. What I'm saying is that all the problems we have with websites are <strong>ones we create ourselves</strong>. Websites aren't broken by default, they are functional, high-performing, and accessible. You break them. You son-of-a-bitch.</p>

        <blockquote cite="https://www.vitsoe.com/us/about/good-design">"Good design is as little design as possible."<br>
            - some German motherfucker
        </blockquote>

    <hr>

    <h2>Epilogue</h2>
    <p>From the philosophies expressed (poorly) above, <a href="http://txti.es">txti</a> was created. You should try it today to make your own motherfucking websites.</p>

    <!-- yes, I know...wanna fight about it? -->
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-45956659-1', 'motherfuckingwebsite.com');
      ga('send', 'pageview');
    </script>

</body>
</html>
"""
]

//
//  ViewController.swift
//  Step1
//
//  Created by sean on 2021/06/20.
//

import UIKit

import YogaKit

class ViewController: UIViewController {
	
	enum Padding {
		static let `default`: YGValue = 8.0
		static let horizontal: YGValue = 8.0
	}
	
	private let backgroundColor: UIColor = .black
	
	fileprivate var shows: [Show] = []
	
	fileprivate let contentView: UIScrollView = UIScrollView(frame: .zero)
	fileprivate let showCellIdentifier = "ShowCell"
	
	// Overall show info
	private let showPopularity = 5
	private let showYear = "2010"
	private let showRating = "TV-14"
	private let showLength = "3 Series"
	private let showCast = "Benedict Cumberbatch, Martin Freeman, Una Stubbs"
	private let showCreators = "Mark Gatiss, Steven Moffat"
	
	// Show selected
	private let showSelectedIndex = 2
	private let selectedShowSeriesLabel = "S3:E3"
	
	// MARK: - Life cycle methods
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		var contentViewRect: CGRect = .zero
		for view in contentView.subviews {
			contentViewRect = contentViewRect.union(view.frame)
		}
		contentView.contentSize = contentViewRect.size
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		shows = Show.loadShows()
		
		let show = shows[showSelectedIndex]
		
		contentView.backgroundColor = backgroundColor
		contentView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.height = YGValue(self.view.bounds.size.height)
			layout.width = YGValue(self.view.bounds.size.width)
			layout.justifyContent = .flexStart
		}
		
		let episodeImageView = UIImageView(frame: .zero)
		episodeImageView.backgroundColor = .gray
		
		let image = UIImage(named: show.image)
		episodeImageView.image = image
		
		let imageWidth = image?.size.width ?? 1.0
		let imageHeight = image?.size.height ?? 1.0
		
		episodeImageView.configureLayout {
			$0.isEnabled = true
			$0.aspectRatio = imageWidth / imageHeight
		}
		
		contentView.addSubview(episodeImageView)
		
		let summaryInfoView = UIView(frame: .zero)
		summaryInfoView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexGrow = 1.0
			layout.flexDirection = .row
			layout.justifyContent = .spaceBetween
		}
		
		let summaryView = UIView(frame: .zero)
		summaryView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = Padding.default
		}
		
		let summaryPopularityLabel = UILabel(frame: .zero)
		summaryPopularityLabel.text = String(repeating: "★", count: showPopularity)
		summaryPopularityLabel.textColor = .red
		summaryPopularityLabel.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexGrow = 1.0
		}
		summaryView.addSubview(summaryPopularityLabel)
		
		for text in [showYear, showRating, showLength] {
			let summaryInfoLabel = UILabel(frame: .zero)
			summaryInfoLabel.text = text
			summaryInfoLabel.font = UIFont.systemFont(ofSize: 14.0)
			summaryInfoLabel.textColor = .lightGray
			summaryInfoLabel.configureLayout { (layout) in
				layout.isEnabled = true
			}
			summaryInfoView.addSubview(summaryInfoLabel)
		}
		summaryView.addSubview(summaryInfoView)
		
		let summaryInfoSpacerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 1))
		summaryInfoSpacerView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexGrow = 3.0
		}
		summaryView.addSubview(summaryInfoSpacerView)
		contentView.addSubview(summaryView)
		
		let titleView = UIView(frame: .zero)
		titleView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = Padding.default
		}

		let titleEpisodeLabel =
			showLabelFor(text: selectedShowSeriesLabel,
									 font: UIFont.boldSystemFont(ofSize: 16.0))
		titleView.addSubview(titleEpisodeLabel)

		let titleFullLabel = UILabel(frame: .zero)
		titleFullLabel.text = show.title
		titleFullLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
		titleFullLabel.textColor = .lightGray
		titleFullLabel.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginLeft = 20.0
			layout.marginBottom = 5.0
		}
		titleView.addSubview(titleFullLabel)
		contentView.addSubview(titleView)

		let descriptionView = UIView(frame: .zero)
		descriptionView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.paddingHorizontal = Padding.horizontal
		}

		let descriptionLabel = UILabel(frame: .zero)
		descriptionLabel.font = UIFont.systemFont(ofSize: 14.0)
		descriptionLabel.numberOfLines = 3
		descriptionLabel.textColor = .lightGray
		descriptionLabel.text = show.detail
		descriptionLabel.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginBottom = 5.0
		}
		descriptionView.addSubview(descriptionLabel)
		
		let castText = "Cast: \(showCast)";
		let castLabel = showLabelFor(text: castText,
																 font: UIFont.boldSystemFont(ofSize: 14.0))
		descriptionView.addSubview(castLabel)

		let creatorText = "Creators: \(showCreators)"
		let creatorLabel = showLabelFor(text: creatorText,
																		font: UIFont.boldSystemFont(ofSize: 14.0))
		descriptionView.addSubview(creatorLabel)

		contentView.addSubview(descriptionView)

		let actionsView = UIView(frame: .zero)
		actionsView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = Padding.default
		}

		let addActionView =
			showActionViewFor(imageName: "add", text: "My List")
		actionsView.addSubview(addActionView)

		let shareActionView =
			showActionViewFor(imageName: "share", text: "Share")
		actionsView.addSubview(shareActionView)

		contentView.addSubview(actionsView)
		
		let tabsView = UIView(frame: .zero)
		tabsView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = Padding.default
		}

		let episodesTabView = showTabBarFor(text: "EPISODES", selected: true)
		tabsView.addSubview(episodesTabView)
		let moreTabView = showTabBarFor(text: "MORE LIKE THIS", selected: false)
		tabsView.addSubview(moreTabView)

		contentView.addSubview(tabsView)

		let showsTableView = UITableView()
		showsTableView.delegate = self
		showsTableView.dataSource = self
		showsTableView.backgroundColor = backgroundColor
		showsTableView.register(ShowTableViewCell.self,
														forCellReuseIdentifier: showCellIdentifier)
		showsTableView.configureLayout{ (layout) in
			layout.isEnabled = true
			layout.flexGrow = 1.0
		}
		contentView.addSubview(showsTableView)
		
		view.addSubview(contentView)
		
		contentView.yoga.applyLayout(preservingOrigin: false)
	}
}

// MARK: - Private methods

private extension ViewController {
	func showLabelFor(
		text: String,
		font: UIFont = UIFont.systemFont(ofSize: 14.0)) -> UILabel {
		let label = UILabel(frame: .zero)
		label.font = font
		label.textColor = .lightGray
		label.text = text
		label.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginBottom = 5.0
		}
		return label
	}
	
	// TODO: Add private methods below
	func showActionViewFor(imageName: String, text: String) -> UIView {
		let actionView = UIView(frame: .zero)
		actionView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.alignItems = .center
			layout.marginRight = 20.0
		}
		let actionButton = UIButton(type: .custom)
		actionButton.setImage(UIImage(named: imageName), for: .normal)
		actionButton.configureLayout{ (layout) in
			layout.isEnabled = true
			layout.padding = 10.0
		}
		actionView.addSubview(actionButton)
		let actionLabel = showLabelFor(text: text)
		actionView.addSubview(actionLabel)
		return actionView
	}

	func showTabBarFor(text: String, selected: Bool) -> UIView {
		// 1
		let tabView = UIView(frame: .zero)
		tabView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.alignItems = .center
			layout.marginRight = 20.0
		}
		// 2
		let tabLabelFont = selected ?
			UIFont.boldSystemFont(ofSize: 14.0) :
			UIFont.systemFont(ofSize: 14.0)
		let fontSize: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: tabLabelFont])
		// 3
		let tabSelectionView =
			UIView(frame: CGRect(x: 0, y: 0, width: fontSize.width, height: 3))
		if selected {
			tabSelectionView.backgroundColor = .red
		}
		tabSelectionView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginBottom = 5.0
		}
		tabView.addSubview(tabSelectionView)
		// 4
		let tabLabel = showLabelFor(text: text, font: tabLabelFont)
		tabView.addSubview(tabLabel)

		return tabView
	}

}

// MARK: - UITableViewDataSource methods

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return shows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: ShowTableViewCell =
			tableView.dequeueReusableCell(withIdentifier: showCellIdentifier, for: indexPath) as! ShowTableViewCell
		cell.show = shows[indexPath.row]
		return cell
	}
	
}

// MARK: - UITableViewDelegate methods

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Selected row \(indexPath.row)")
	}
}

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
	
	enum Margin {
		static let left: YGValue = 16.0
		static let titleLeft: YGValue = 20.0
		static let right: YGValue = 20.0
		static let bottom: YGValue = 5.0
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
	private let showSelectedIndex = 0
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
		contentView.configureLayout {
			$0.isEnabled = true
			$0.height = YGValue(self.view.bounds.size.height)
			$0.width = YGValue(self.view.bounds.size.width)
			$0.justifyContent = .flexStart
		}
		
		// MARK: - ImageView
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
		
		// MARK: - SummaryView
		let summaryView = UIView(frame: .zero)
		summaryView.configureLayout {
			$0.isEnabled = true
			$0.flexDirection = .row
			$0.justifyContent = .spaceEvenly
			$0.padding = Padding.default
		}
		
		let summaryInfoView = UIView(frame: .zero)
		summaryInfoView.configureLayout {
			$0.isEnabled = true
			$0.flexGrow = 1.0
			$0.flexDirection = .row
			$0.justifyContent = .spaceEvenly
		}
		
		for text in [showYear, showRating, showLength] {
			let summaryInfoLabel = UILabel(frame: .zero)
			summaryInfoLabel.text = text
			summaryInfoLabel.font = UIFont.systemFont(ofSize: 14.0)
			summaryInfoLabel.textColor = .lightGray
			summaryInfoLabel.configureLayout {
				$0.isEnabled = true
			}
			summaryInfoView.addSubview(summaryInfoLabel)
		}
		summaryView.addSubview(summaryInfoView)
		
		// summaryPopularityLabel의 flexGrow를 제거 했기 때문에 frame은 의미 없음.
		// summaryInfoSpacerView가 최대한으로 늘어난다.
		let summaryInfoSpacerView = UIView(frame: .zero)
		summaryInfoSpacerView.configureLayout {
			$0.isEnabled = true
			$0.flexGrow = 0.8
		}
		summaryView.addSubview(summaryInfoSpacerView)
		
		// summaryPopularityLabel은 최소 공간을 잡는다.
		let summaryPopularityLabel = UILabel(frame: .zero)
		summaryPopularityLabel.text = String(repeating: "★", count: showPopularity)
		summaryPopularityLabel.textColor = .red
		summaryPopularityLabel.configureLayout {
			$0.isEnabled = true
			$0.flexGrow = 0.2
		}
		summaryView.addSubview(summaryPopularityLabel)
		contentView.addSubview(summaryView)
		
		// MARK: - titleView
		let titleView = UIView(frame: .zero)
		titleView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = Padding.default
		}

		let titleEpisodeLabel = UILabel(frame: .zero)
		titleEpisodeLabel.text = selectedShowSeriesLabel
		titleEpisodeLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
		titleEpisodeLabel.textColor = .lightGray
		titleEpisodeLabel.configureLayout {
			$0.isEnabled = true
			$0.marginBottom = Margin.bottom
			$0.marginLeft = Margin.left
		}
		titleView.addSubview(titleEpisodeLabel)

		let titleFullLabel = UILabel(frame: .zero)
		titleFullLabel.text = show.title
		titleFullLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
		titleFullLabel.textColor = .lightGray
		titleFullLabel.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginLeft = Margin.titleLeft
			layout.marginBottom = Margin.bottom
		}
		titleView.addSubview(titleFullLabel)
		contentView.addSubview(titleView)

		// MARK: - DescriptionView
		let descriptionView = UIView(frame: .zero)
		descriptionView.configureLayout {
			$0.isEnabled = true
			$0.paddingHorizontal = Padding.horizontal
			$0.marginLeft = Margin.left
		}

		let descriptionLabel = UILabel(frame: .zero)
		descriptionLabel.font = UIFont.systemFont(ofSize: 14.0)
		descriptionLabel.numberOfLines = 0
		descriptionLabel.textColor = .lightGray
		descriptionLabel.text = show.detail
		descriptionLabel.configureLayout {
			$0.isEnabled = true
			$0.marginBottom = 10.0
		}
		descriptionView.addSubview(descriptionLabel)
		
		let castText = "Cast: \(showCast)";
		let castLabel = showLabelFor(
			text: castText,
			font: UIFont.boldSystemFont(ofSize: 14.0)
		)
		descriptionView.addSubview(castLabel)

		let creatorText = "Creators: \(showCreators)"
		let creatorLabel = showLabelFor(
			text: creatorText,
			font: UIFont.boldSystemFont(ofSize: 14.0)
		)
		descriptionView.addSubview(creatorLabel)

		contentView.addSubview(descriptionView)

		// MARK: - ActionsView
		let actionsView = UIView(frame: .zero)
		actionsView.configureLayout {
			$0.isEnabled = true
			$0.flexDirection = .row
			$0.padding = Padding.default
			$0.marginLeft = Margin.left
		}

		let addActionView = showActionViewFor(imageName: "add", text: "My List")
		actionsView.addSubview(addActionView)

		let shareActionView = showActionViewFor(imageName: "share", text: "Share")
		actionsView.addSubview(shareActionView)

		contentView.addSubview(actionsView)
		
		// MARK: - TabsView
		let tabsView = UIView(frame: .zero)
		tabsView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.alignContent = .spaceAround
			layout.padding = Padding.default
		}

		let episodesTabView = showTabBarFor(text: "EPISODES", isSelected: true)
		tabsView.addSubview(episodesTabView)
		let moreTabView = showTabBarFor(text: "MORE LIKE THIS", isSelected: false)
		tabsView.addSubview(moreTabView)

		contentView.addSubview(tabsView)

		// MARK: - TableView
		let showsTableView = UITableView()
		showsTableView.delegate = self
		showsTableView.dataSource = self
		showsTableView.backgroundColor = backgroundColor
		showsTableView.register(
			ShowTableViewCell.self,
			forCellReuseIdentifier: showCellIdentifier
		)
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
		label.configureLayout {
			$0.isEnabled = true
			$0.marginBottom = Margin.bottom
		}
		return label
	}
	
	// TODO: Add private methods below
	func showActionViewFor(imageName: String, text: String) -> UIView {
		let actionView = UIView(frame: .zero)
		actionView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.alignItems = .center
			layout.marginRight = Margin.right
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

	func showTabBarFor(text: String, isSelected: Bool) -> UIView {
		let tabView = UIView(frame: .zero)
		tabView.configureLayout {
			$0.isEnabled = true
			$0.alignItems = .center
			$0.marginLeft = Margin.left
		}
		
		let tabLabelFont: UIFont = isSelected ? .boldSystemFont(ofSize: 14) : .systemFont(ofSize: 14)
		let textSize: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: tabLabelFont])
		
		let tabLabel = showLabelFor(text: text, font: tabLabelFont)
		tabView.addSubview(tabLabel)
		
		let tabSelectionView: UIView = .init(frame: .zero)
		tabSelectionView.backgroundColor = isSelected ? .red : .clear
		tabSelectionView.configureLayout {
			$0.isEnabled = true
			$0.marginBottom = Margin.bottom
			$0.height = 3
			$0.width = YGValue(textSize.width)
		}
		tabView.addSubview(tabSelectionView)
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

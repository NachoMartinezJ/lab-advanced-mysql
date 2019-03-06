# Challenge 1
# Step 1
SELECT ta.au_id, ta.title_id, ROUND(titles.advance * ta.royaltyper / 100, 2) as Advance, ROUND(titles.price * s.qty * titles.royalty / 100 * ta.royaltyper / 100, 2) as salesRoyalty
FROM titleauthor ta
INNER JOIN sales as s
ON s.title_id = ta.title_id
INNER JOIN titles
ON titles.title_id = ta.title_id;

# Step 2
SELECT title_id , au_id, SUM(salesRoyalty) as summed_royalties, Advance FROM (
	SELECT ta.au_id, ta.title_id, ROUND(titles.advance * ta.royaltyper / 100, 2) as Advance, ROUND(titles.price * s.qty * titles.royalty / 100 * ta.royaltyper / 100, 2) as salesRoyalty
	FROM titleauthor ta
	INNER JOIN sales as s
	ON s.title_id = ta.title_id
	INNER JOIN titles
	ON titles.title_id = ta.title_id
) as author_royalties
GROUP BY au_id, title_id;

# Step 3
SELECT au_id, (Advance + summed_royalties) as profits FROM (
	SELECT title_id , au_id, SUM(salesRoyalty) as summed_royalties, Advance FROM (
		SELECT ta.au_id, ta.title_id, ROUND(titles.advance * ta.royaltyper / 100, 2) as Advance, ROUND(titles.price * s.qty * titles.royalty / 100 * ta.royaltyper / 100, 2) as salesRoyalty
		FROM titleauthor ta
		INNER JOIN sales as s
		ON s.title_id = ta.title_id
		INNER JOIN titles
		ON titles.title_id = ta.title_id
	) as author_royalties
	GROUP BY au_id, title_id
) as author_profits
GROUP BY au_id, profits
ORDER BY profits DESC;

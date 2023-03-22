# SQL-Practice
Practice is enacted on the following schema.
![Database Schema](../main/ImageAssets/DatabaseEER)


## Query 1
> SELECT h.consignmentId, itemNumber, h.clientId, clientName, ownerName, dateRecieved, valuationReason, valuationId, jewelleryType, description, majorMaterial, collection, dateMade, keywordDescription
> FROM owner i
> JOIN
>	 (SELECT g.consignmentId, g.clientId, clientName, ownerId, itemNumber, dateRecieved, valuationReason, valuationId, jewelleryType, description, majorMaterial, collection, dateMade, keywordDescription
> 	FROM client f
> 	JOIN
> 		(SELECT e.consignmentId, clientId, itemNumber, dateRecieved, valuationReason, valuationId, jewelleryType, description, majorMaterial, collection, dateMade, keywordDescription
> 		FROM consignment e
> 		JOIN
> 			(SELECT *
> 			FROM consignmentitem a
> 			JOIN keyword b
> 			ON a.description LIKE CONCAT ('%', b.keyword, '%')
> 			AND b.keyword = 'diamond') c
> 		ON e.consignmentId = c.consignmentId
> 		AND valuationId IS NULL) g
> 	ON f.clientId = g.clientId) h
> ON i.ownerId = h.ownerId
> ORDER BY h.consignmentId, h.itemNumber
> ;

In this query, I utilised multiple inner joins with nestled queries. The inner most query utilizes CONCAT and wildcards to join on a match of the item’s description and the keyword table. This query is designed to show jewellery that has the word ‘diamond’ in its description and needs valuation. Further joins and queries were added to provide more information like Client Name, ownerName, dateRecieved, valuationReason etc.  This would be important for Tsavorite Jewellery Valuers if they decide to complete a particular material’s valuation first. It also helps them identify items that require valuation.

## Query 2
> SELECT consignmentId, itemNumber, jewelleryType, description, DaysWaited, ownerName, clientName, businessIndicator, email, contactConsent
> FROM owner f
> JOIN
> 	(SELECT clientName, businessIndicator, ownerId, email, contactConsent, c.*
> 	FROM client d
> 	JOIN
> 		(SELECT a.consignmentId, clientId, itemNumber, jewelleryType, description, DATEDIFF(CURDATE(), dateRecieved) AS 'DaysWaited'
> 		FROM consignmentitem a
> 		JOIN consignment b
> 		ON a.consignmentId = b.consignmentId
>         AND valuationId IS NULL) c
> 	ON c.clientId = d.clientId) e
> ON e.ownerId = f.ownerId
> ORDER BY DaysWaited DESC
> ; 

In this query, multiple inner joins with nestled queries were also used. However, this query introduced the DATEDIFF function and as well as the CURDATE function. When used together with valuationId being NULL, we can get ‘DaysWaited’ for jewellery that is currently still awaiting valuation. The other joins were included to display other details related to the jewellery that may be important to Tsavorite Jewellery Valuers (i.e contact them after a x number of days waited to inform of the delay). This query also enables them to identify which next items for valuation, hence the descending ORDER BY for DaysWaited.

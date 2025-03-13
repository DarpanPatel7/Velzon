/**
 * 09-01-2025
 * darpan
 * Renders the grid (table body) dynamically based on the response data.
 *
 * @param {Object} res - The response object containing the grid data.
 * @param {number} index - The current page index for pagination.
 * @param {Function} [customRowGenerator] - Optional callback to customize the row generation logic for rows.
 * @param {Function} [customNoRecordsMessage] - Optional callback to customize the "No records found" message.
 * @param {string} [tableBodySelector="#tbodyDV"] - Selector for the table body to update.
 */
function renderGrid(res, index, customRowGenerator, customNoRecordsMessage, tableBodySelector = "#tbodyDV") {
    const mainData = res.resultList; // Extract the list of data from the response
    const perPage = res.perPage ?? 10; // Default items per page to 10 if not provided
    let i = (index - 1) * perPage + 1; // Calculate the starting serial number based on the page index
    let strTBody = "";

    if (mainData && mainData.length) {
        // Use custom row generator if provided, otherwise use default logic
        if (typeof customRowGenerator === "function") {
            strTBody = mainData.map((value, idx) => customRowGenerator(value, i + idx)).join("");
        } else {
            // Iterate over the data and generate rows dynamically
            mainData.forEach(value => {
                // Construct a table row with the data
                strTBody += `
                    <tr>
                        <td>${i}</td>
                    </tr>`;
                i++; // Increment serial number
            });
        }
    } else {
        // Use custom "No records found" message if provided, otherwise use default logic
        if (typeof customNoRecordsMessage === "function") {
            strTBody = customNoRecordsMessage();
        } else {
            strTBody = `
                <tr align="center">
                    <td colspan='1' class='no-record'>No matching records found!</td>
                </tr>`;
        }
    }

    // Dynamically update the table body with the generated rows
    $(tableBodySelector).html(strTBody);
}


/**
 * Renders a pagination control and binds it to a specified HTML element.
 * 
 * @param {Object} res - Response object containing pagination data.
 * @param {Object} params - Parameters to pass to the BindGrid function.
 * @param {number} currentPage - The current active page.
 * @param {Function} bindFunction - JavaScript function to execute for page navigation.
 * @param {string} targetElementId - ID of the target element where pagination will be rendered.
 * @param {number} skipAmount - Number of pages to skip for skip-back/skip-forward links.
 * @param {number} numButtons - Number of page buttons to display in the pagination control.
 */
function renderPagination(res, params, currentPage, bindFunction = "BindGrid", targetElementId = "PaginationListArea", skipAmount = 4, numButtons = 3) {
    let pagstrSubStr = "";
    const pageCount = res.pageCount;

    /**
     * Creates a pagination link.
     * 
     * @param {number} pageNum - The page number to link to.
     * @param {string|number} label - The label for the link.
     * @param {boolean} isActive - Whether the link is for the active page.
     * @returns {string} HTML string for the page link.
     */
    function createPageLink(pageNum, label, isActive) {
        const paramStr = Object.entries(params)
            .map(([key, value]) => `${key}: '${value}'`)
            .join(', ');
        const jsBindGrid = `javascript:${bindFunction}({${paramStr}}, ${pageNum})`;

        return `
            <li class="page-item">
                <a class="page-link ${isActive ? "active" : ""}" href="${isActive ? "javascript:;" : jsBindGrid}">
                    ${label}
                </a>
            </li>`;
    }

    // Add "<<" link to go to the first page
    if (currentPage > 1) {
        pagstrSubStr += createPageLink(1, "<<", false);
    }

    // Add "Skip Back" link if not on the first page set
    if (currentPage > skipAmount) {
        pagstrSubStr += createPageLink(currentPage - skipAmount, `${currentPage - skipAmount}`, false);
    }

    // Calculate the range of pages to display
    let startPage, endPage;

    if (pageCount <= numButtons) {
        // If there are fewer pages than the number of buttons, show all pages
        startPage = 1;
        endPage = pageCount;
    } else {
        // Determine the start and end pages
        startPage = Math.max(1, currentPage - Math.floor(numButtons / 2));
        endPage = Math.min(pageCount, currentPage + Math.floor(numButtons / 2));

        // Adjust the range if we're near the beginning or end
        if (currentPage - Math.floor(numButtons / 2) < 1) {
            endPage = Math.min(pageCount, numButtons);
        }
        if (currentPage + Math.floor(numButtons / 2) > pageCount) {
            startPage = Math.max(1, pageCount - numButtons + 1);
        }
    }

    // Add "..." before first visible page if needed
    if (startPage > 1) {
        pagstrSubStr += `<li class="page-item"><a class="page-link dotted" href="javascript:;">...</a></li>`;
    }

    // Add page links within the range
    for (let i = startPage; i <= endPage; i++) {
        pagstrSubStr += createPageLink(i, i, i === currentPage);
    }

    // Add "..." after last visible page if needed
    if (endPage < pageCount) {
        pagstrSubStr += `<li class="page-item"><a class="page-link dotted" href="javascript:;">...</a></li>`;
    }

    // Add "Skip Forward" link if not on the last page set
    if (currentPage < pageCount - skipAmount) {
        pagstrSubStr += createPageLink(currentPage + skipAmount, `${currentPage + skipAmount}`, false);
    }

    // Add ">>" link to go to the last page
    if (currentPage < pageCount) {
        pagstrSubStr += createPageLink(pageCount, ">>", false);
    }

    // Render the pagination HTML into the target element
    $(`#${targetElementId}`).html(pageCount > 1 ? pagstrSubStr : "");
}
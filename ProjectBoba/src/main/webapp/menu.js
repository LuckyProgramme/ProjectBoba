document.addEventListener("DOMContentLoaded", function () {
            fetch("MenuServlet")
                .then(response => response.json())
                .then(data => {
                	console.log("Data from servlet:", data); // Log the entire data
                    renderMenu(data);
                })
                .catch(error => console.error("Error loading menu:", error));
        });

		function renderMenu(menuItems, categoryFilter = 'all') {
		    console.log("renderMenu called with:", menuItems, categoryFilter);
		    const menuGrid = document.querySelector(".menu-grid");
		    menuGrid.innerHTML = "";

		    const filteredItems = categoryFilter === 'all' ? menuItems : menuItems.filter(item => item.category.toLowerCase().replace(' ', '-') === categoryFilter);

		    filteredItems.forEach(item => {
		        console.log("  Processing item:", item);
		        const menuItem = document.createElement("div");
		        menuItem.className = `menu-item ${item.category.toLowerCase().replace(' ', '-')}`;

		        let sizesHTML = '';
		        if (item.sizes && Array.isArray(item.sizes)) {
		            item.sizes.forEach(size => {
		                console.log("  Processing size:", size);
		                const isActive = size.size === 'Small' ? 'active' : '';
		                sizesHTML += `
		                    <button
		                        class="size-btn ${isActive}"
		                        data-item-id="${item.item_id}"  data-size="${size.size}"
		                        data-price="${size.price}"
		                        onclick="selectSize(this, '${item.item_id}', '${item.name}', '${size.size}', ${size.price}, '${item.image}', '${item.category}')"
		                    >
		                        ${size.size.charAt(0)} <span class="size-price">₱${size.price.toFixed(2)}</span>
		                    </button>
		                `;
		            });
		        }
		        console.log("  sizesHTML:", sizesHTML);

		        menuItem.innerHTML = `
		            <img src="${item.image}" alt="${item.name}"/>
		            <div class="menu-item-info">
		                <h3>${item.name}</h3>
		                <div class="sizes-row">
		                    ${sizesHTML}
		                </div>
		                <button class="btn btn-primary btn-block add-to-order-btn" data-item-id="${item.item_id}">  Add to Order
		                </button>
		            </div>
		        `;
		        console.log("MenuItem", menuItem.innerHTML);
		        menuGrid.appendChild(menuItem);
		    });
		}

        function filterMenu(category) {
            fetch("MenuServlet")
                .then(response => response.json())
                .then(data => {
                    renderMenu(data, category);
                    const categoryButtons = document.querySelectorAll('.category-btn');
                    categoryButtons.forEach(button => {
                        button.classList.remove('active');
                        if (button.textContent.toLowerCase().replace(' ', '-') === category) {
                            button.classList.add('active');
                        } else if (category === 'all' && button.textContent === 'All Items') {
                            button.classList.add('active');
                        }
                    });
                })
                .catch(error => console.error("Error filtering menu:", error));
        }

        function selectSize(button, item_id, name, size, price, image, category) {
            const sizeButtons = button.parentNode.querySelectorAll('.size-btn');
            sizeButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            const selectedItem = { id: item_id, name: name, size: size, price: price, image: image, category: category };
            console.log("Selected Item:", selectedItem);
        }

        function closeToppingsModal() {
            document.getElementBy
("toppingsModal").style.display = "none";
			}
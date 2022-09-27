describe('Navigation', () => {

  it("should visit root", () => {
    cy.visit('/')
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("clicks on add to cart for product and cart count changes", () => {
    cy.get(".products article")
    cy.contains('Add')
      .click({force: true})
    cy.contains("My Cart (1)");
  });
})
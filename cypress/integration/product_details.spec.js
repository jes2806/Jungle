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

  it("clicks on a product and goes to product page", () => {
    cy.get(".products article")
    .first()
    .click()
    cy.contains("The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks.");
  });
})